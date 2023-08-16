import sys, time, argparse
import socket 
from util import *

RECV_BUFFER_SIZE = 2048

# Get port to listen on as command line argument
def get_args(argv):
    parser = argparse.ArgumentParser(description="UDP File Transfer Server using Go-Back-N protocol")
    parser.add_argument('-p', '--port', required=False, default=12000, type=int)
    parser.add_argument('-f', '--filename', required=False, default="copied_file.txt")
    parser.add_argument('-t', '--final-timeout', required=False, default=2.0, type=float)
    return parser.parse_args()

def main(argv):
    # Process commandline arguments
    args = get_args(argv)
    final_timeout = args.final_timeout

    # Create a UDP socket
    server_socket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    print("Opened Server socket")

    # Assign IP address and port number to socket
    server_socket.bind(('', args.port))
    print("Bound socket on port " + str(args.port))

    # Set up
    outfile = open(args.filename, 'wb')
    start_time = None 
    bytes_recvd = 0
    expected_seq = 0

    while True:
        try:
            # Receive the client data
            pkt, addr = server_socket.recvfrom(RECV_BUFFER_SIZE)
            pkt_header = PacketHeader(pkt[:PacketHeader.header_len])
            data = pkt[PacketHeader.header_len:PacketHeader.header_len+pkt_header.length]

            # Start timer on first pkt receipt to avoid counting time when
            # server is waiting but client hasn't been started yet
            if not start_time:
                start_time = time.time()
                
            #print("{} {}".format(pkt_header.seq_num, data))

            # Received the next packet I was expecting. Deliver (write to file)
            # and update expected seq
            if pkt_header.seq_num == expected_seq:
                if pkt_header.type == PacketHeader.TYPE_DATA:
                    # Write data to file
                    outfile.write(data)
                    bytes_recvd += len(data)

                    # Periodic reporting
                    if pkt_header.seq_num % 1000 == 0:
                        cur_time = time.time()
                        elapsed_time = cur_time - start_time
                        throughput = (bytes_recvd * 8) / (elapsed_time) / 1000000
                        print("Packet {}\tBytes Recvd {}\tTime Elapsed {}\tThroughput "\
                              "{} Mbps".format(pkt_header.seq_num, bytes_recvd, elapsed_time,
                              throughput))
                elif pkt_header.type == PacketHeader.TYPE_END:
                    # Data transfer is done. Close file and set final timeout
                    print("Got last packet with seq {}. Waiting {} sec and then "\
                          "quitting".format(pkt_header.seq_num, final_timeout))
                    outfile.close()
                    end_time = time.time()
                    server_socket.settimeout(final_timeout)

                # Update expected sequence number and stats
                expected_seq += 1

            # Else, received packet is not the next one I'm expecting, so do
            # nothing (i.e. drop the packet). Recall that we can improve
            # performance by buffering instead (like TCP does) but this requires a
            # bit more logic

            # Send ACK
            ack_header = PacketHeader(seq_num=expected_seq, length=0)
            server_socket.sendto(bytes(ack_header), addr)

        except socket.timeout as e:
            print("Final wait time expired. Exiting...")
            break

    # Close socket
    server_socket.close()

    # Print stats
    elapsed_time = end_time - start_time
    throughput = (bytes_recvd * 8) / (elapsed_time)
    print("Bytes transferred: {}".format(bytes_recvd))
    print("Time Elapsed: {} sec".format(elapsed_time))
    print("Throughput: {} Mbps".format(throughput/1000000.0))

if __name__ == "__main__":
    main(sys.argv[1:])
