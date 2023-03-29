#!/bin/bash

figlet -f standard Press-Enum

echo ''
echo '**********************************************************************************************************************************'
echo "*                                                                                                                                *"
echo "* Author: Kharim Mchatta                                                                                                         *"
echo "*                                                                                                                                *"
echo "* Tool-Name: Substat                                                                                                             *"
echo "*                                                                                                                                *"
echo "* Version: 1.0                                                                                                                   *"
echo "*                                                                                                                                *"
echo "* Substat is a script that checks the status code of the subdomain                                                               *"
echo "*                                                                                                                                *"
echo "* Disclaimer: the tool is not intended for malicious use, any malicious use of the tool shall not hold the author responsible.   *"
echo "*                                                                                                                                *"
echo "**********************************************************************************************************************************"

echo ""
echo ""
echo ""
echo ""

# Ask the user for the file that contains the list of subdomains
read -p "Please enter the name of the file containing the list of subdomains:" subdomains_file

# Check if the file exists
if [ ! -f $subdomains_file ]; then
  echo "Error: $subdomains_file does not exist."
  exit 1
fi

# Ask the user for the name of the output file
read -p "Please enter the name of the output file: " output_file
echo ''
echo ''

# Print header for the output
echo "Subdomain                                         status " | tee $output_file
echo "----------------------------------               --------" | tee -a $output_file

# Loop through each subdomain in the file and check its status code
while read subdomain; do
  status_code=$(curl -isL -o /dev/null -w "%{http_code}" $subdomain)
  printf "%-50s %s\n" "$subdomain" "$status_code" | tee -a $output_file
done < $subdomains_file
echo ''
echo ''
echo "Done! The subdomain list and its status code have been saved to $output_file."
