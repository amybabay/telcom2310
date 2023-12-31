# TCP_Ping_Client.py
import sys, time, argparse
import socket

RECV_BUFFER_SIZE = 1024

# Get the server hostname and port as command line arguments
def get_args(argv):
    parser = argparse.ArgumentParser(description="TCP Ping Client")
    parser.add_argument('-p', '--port', required=False, default=12000, type=int)
    parser.add_argument('-a', '--address', required=True)
    parser.add_argument('-n', '--num-pings', required=False, default=10, type=int)
    return parser.parse_args()

def main(argv):
    args = get_args(argv)

    # Init RTT stats
    avg_rtt = 0
    max_rtt = 0
    min_rtt = 0
    resp_count = 0

    # Ping for num_pings times
    pseq = 0
    while pseq < args.num_pings: 
        # Get current time
        send_time = time.time()

        # Format the message to be sent
        pseq += 1
        data = "Ping " + str(pseq) + " " + time.ctime(send_time)
    
        # Create TCP client socket, connect to server, and send data 
        client_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        client_socket.connect((args.address, args.port))
        client_socket.send(data.encode())

        # Receive the server response
        message = client_socket.recv(RECV_BUFFER_SIZE)  

        # Get received time and calculate RTT (converting from sec to ms)
        recv_time = time.time()
        rtt_ms = (recv_time - send_time) * 1000

        # Display results
        print("Ping {:3d}\tRTT {:8.4f}\tReply: {}".format(pseq, rtt_ms,
              message.decode()))

        # Update stats
        resp_count += 1
        avg_rtt += rtt_ms
        if rtt_ms > max_rtt:
            max_rtt = rtt_ms
        if min_rtt == 0 or rtt_ms < min_rtt:
            min_rtt = rtt_ms

        # Close the client socket
        client_socket.close()

    # Print out final stats
    print("\nReceived {}/{} responses".format(resp_count, pseq))
    print("Min RTT: {:8.4f}ms".format(min_rtt))
    print("Max RTT: {:8.4f}ms".format(max_rtt))
    print("Avg RTT: {:8.4f}ms".format(avg_rtt / resp_count))
 
if __name__ == "__main__":
    main(sys.argv[1:])
