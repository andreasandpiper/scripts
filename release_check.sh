#!/bin/bash
# include 3 paramters, first release branch, second is the JIRA group acronym, third is an array of ticket numbers.

branch=$1
group=$2

# runs through series of checks for missing pararmeters
# then checks for valid parameters
example="example command: ./script DO 454 542 654"
if [ -z "$branch" ]; then
	echo "Please give the following paramters:"
	echo "1st: branch name, such as develop or tags/2019.3.2.1"
	echo "2nd: JIRA group, such as DO or SN"
       	echo "3rd, 4th ... Jira ticket numbers such as 432 or 432"	
	echo $example
	exit
elif [ -z "$group" ]; then
	echo "Include JIRA group, such as DO"
	echo $example
	exit
elif [ -z "$3" ]; then
	echo "Include JIRA ticket numbers, such as 545"
	echo $example
	exit
else
	if [ "$branch" -eq $1 2> /dev/null || "$group" -eq $2 2> /dev/null ]; then
		echo "Please enter a valid branch, such as tags/2019.1.1"
		exit
	fi
fi

# Inform if release or regular branch
if [[ "$branch" =~ "tags" ]]; then
	echo "The following tickets are missing in release: $branch"
else
	echo "The following tickets are missing in branch: $branch"
fi


# get the log of the release branch
log=$(git log $1)

# loops through array of tickets and grep log, if nothing in log, add the number to the output
declare -a MISSING_TICKETS

for t in "${@:3}"; do
	if ! grep -q "${group}-${t}" <<< "$log"; then
		MISSING_TICKETS+="$t "
	fi
done

# output
echo ${MISSING_TICKETS[*]}
