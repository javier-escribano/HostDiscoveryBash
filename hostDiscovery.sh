#!/bin/bash

if [ $2 ]; then

	ip_address=$2

	if [[ $1 = "-r" ]]
	then

		if [[ $(echo $ip_address | cut -f 1 -d '.') -ge 0 && $(echo $ip_address | cut -f 1 -d '.') -le 127 ]]
		then
			ip=$(echo $ip_address | cut -f 1 -d '.')

			for i in $(seq 0 255); do
				for j in $(seq 0 255); do
					for k in $(seq 0 255); do
						if [[ $(timeout 1 bash -c "ping -c 1 $ip.$i.$j.$k | sed -n '5p' | cut -d ' ' -f 4") -eq 1 ]]
						then
							echo -e "Host $ip.$i.$j.$k - ACCESSIBLE"
						fi
					done;
				done;
			done;

		elif [[ $(echo $ip_address | cut -f 1 -d '.') -ge 128 && $(echo $ip_address | cut -f 1 -d '.') -le 191 ]]
		then
			ip=$(echo $ip_address | cut -f 1,2 -d '.')

			for i in $(seq 0 255); do
				for j in $(seq 0 255); do
					if [[ $(timeout 1 bash -c "ping -c 1 $ip.$i.$j | sed -n '5p' | cut -d ' ' -f 4") -eq 1 ]]
					then
						echo -e "Host $ip.$i.$j - ACCESSIBLE"
					fi
				done;
			done;

		elif [[ $(echo $ip_address | cut -f 1 -d '.') -ge 192 && $(echo $ip_address | cut -f 1 -d '.') -le 223 ]]
		then
			ip=$(echo $ip_address | cut -f 1-3 -d '.')

			for i in $(seq 0 255); do
				if [[ $(timeout 1 bash -c "ping -c 1 $ip.$i | sed -n '5p' | cut -d ' ' -f 4") -eq 1 ]]
				then
					echo -e "Host $ip.$i - ACCESSIBLE"
				fi
			done;

		elif [[ $ip_address = "224.0.0.0" ]]
		then
			echo -e "\n[*] Multicast address must not be used for host discovery purposes, try another one!\n"

		elif [[ $ip_address = "255.255.255.255" ]]
		then
			echo -e "\n[*] Broadcast address must not be used for host discovery purposes, try another one!\n"

		fi

	elif [[ $1 = "-u" ]]
	then
		if [[ $(timeout 1 bash -c "ping -c 1 $ip_address | sed -n '5p' | cut -d ' ' -f 4") -eq 1 ]]
		then
			echo -e "Host $ip_address - ACCESSIBLE"
		else
			echo -e "Host $ip_address - INACCESSIBLE"
		fi

	elif [[ $1 = "-h" ]]
	then

		echo -e "\n[*] Usage: ./hostDiscoveryy.sh <command> <ip_address>\n"
                echo -e "-h : Show the help menu\n"
                echo -e "-r : Make a Host Discovery Range Network by its Class\n"
                echo -e "-u : Make a Unique Host Discovery\n"

	fi

else
	echo -e "\n[*] Usage: ./hostDiscoveryy.sh <command> <ip_address>\n"
	echo -e "-h : Show the help menu\n"
	echo -e "-r : Make a Host Discovery Range Network by its Class\n"
	echo -e "-u : Make a Unique Host Discovery\n"

	exit 1
fi
