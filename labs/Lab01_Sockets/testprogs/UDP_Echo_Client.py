# UDP_Echo_Client.py
import sys, argparse
import socket

RECV_BUFFER_SIZE = 1024

# Get the server hostname and port as command line arguments
def get_args(argv):
    parser = argparse.ArgumentParser(description="UDP Echo Client")
    parser.add_argument('-p', '--port', required=False, default=12000, type=int)
    parser.add_argument('-a', '--address', required=True)
    return parser.parse_args()

def main(argv):
    args = get_args(argv)

    # Create UDP client socket (note use of SOCK_DGRAM for UDP datagram) 
    client_socket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)

    # Get message from user
    message = input("Enter your message: ")
    
    # Send the message
    client_socket.sendto(message.encode(), (args.address, args.port))

    # Receive the server response
    reply, addr = client_socket.recvfrom(RECV_BUFFER_SIZE)  
    print("Received response from {}:{}\t{}".format(addr[0], addr[1], reply.decode()))

    # Close the client socket
    client_socket.close()
 
if __name__ == "__main__":
    main(sys.argv[1:])
