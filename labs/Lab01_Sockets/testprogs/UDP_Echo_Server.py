# UDP_Echo_Server.py
import sys, argparse
import socket 

RECV_BUFFER_SIZE = 1024

# Get port to listen on as command line argument
def get_args(argv):
    parser = argparse.ArgumentParser(description="UDP Echo Server")
    parser.add_argument('-p', '--port', required=False, default=12000, type=int)
    return parser.parse_args()

def main(argv):
    # Process commandline arguments
    args = get_args(argv)

    # Create a UDP socket (note use of SOCK_DGRAM)
    server_socket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    print("Opened Server UDP socket")

    # Assign IP address and port number to socket
    server_socket.bind(('', args.port))
    print("Bound socket on port " + str(args.port))

    while True:
        # Receive the client packet along with the address it is coming from
        message, addr = server_socket.recvfrom(RECV_BUFFER_SIZE)
        message = message.decode()
        print("Received msg from {}:{}\t{}".format(addr[0], addr[1], message))

        # Here we capitalize the message before returning just to show that we
        # can process / modify the message however we want
        message = message.upper()

        # Send response back to the address we received from
        server_socket.sendto(message.encode(), addr)

if __name__ == "__main__":
    main(sys.argv[1:])
