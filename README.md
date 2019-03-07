# scripts
A collection of useful scripts


#### release_check
Params: <branch name> <JIRA project> <ticket #> <ticket #> ...
This script is intended to search the commit log to find which tickets listed are missing, intended for JIRA releases
JIRA tickets begin with a 2 letter group name, such as SN. This is the second parameter
All the other parameters are the tickets to find in the log. This will only work if your teams workflow is to title merges with the ticket number, such as SN-707 

