#!/bin/bash

# Bash Script to Analyze Network Traffic

# Input: Path to the Wireshark pcap file
pcap_file=$1


# Function to extract information from the pcap file
analyze_traffic() {
    # Use tshark or similar commands for packet analysis.
    # Hint: Consider commands to count total packets, filter by protocols (HTTP, HTTPS/TLS),
    # extract IP addresses, and generate summary statistics.
    packets_num=$(tshark -r "$1" | awk '{print $1}' | tail -1 )
    packets_num_http=$(tshark -r "$1" -Y 'http && !ocsp' | wc -l)
    packets_num_https=$(tshark -r "$1" -Y 'tcp.port == 443 || tls' | wc -l)
    ip_destination=$(tshark -r "$1" -E header=y -T fields -e ip.dst | head -6)
    ip_header=$(tshark -r "$1" -E header=y -T fields -e ip.src | head -6)

    # Output analysis summary
    echo "----- Network Traffic Analysis Report -----"
    # Provide summary information based on your analysis
    # Hints: Total packets, protocols, top source, and destination IP addresses.
    echo "1. Total Packets: ${packets_num}"
    echo "2. Protocols:"
    echo "   - HTTP: ${packets_num_http} packets"
    echo "   - HTTPS/TLS: ${packets_num_https} packets"
    echo ""
    echo "3. Top 5 Source IP Addresses:"
    # Provide the top source IP addresses
    echo "${ip_header}"
    echo ""
    echo "4. Top 5 Destination IP Addresses:"
    # Provide the top destination IP addresses
    echo "${ip_destination}"
    echo ""
    echo "----- End of Report -----"
}

# Run the analysis function
analyze_traffic "$1"
