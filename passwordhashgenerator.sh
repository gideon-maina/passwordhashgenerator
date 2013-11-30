#! /bin/bash
#Read input from the keyboard hidden
#The string version for the salt is hectic because even if i use the random function to assign alphanumeric characters this will result in a different salt for same password in a different Computer

echo "Enter the password to hash..."
read -s -r rawpassword

#If i want to use method two with the user supplied salt value 
#echo "Enter the salt to use for the password..."
#read -s saltvalue

echo "1... md5 hash"
echo "2... sha 512 hash"

while true; do
        read -p " Enter choice " query
        case $query in
                [1]*) echo "Case I md5 detected"                                
                echo "Calculating your hash sum..."
                echo $rawpassword
                 # perl at the server has some locale warnings
                 # hashedMD5pass=`perl -e 'print crypt('$rawpassword', q($1$'$saltvalue$')), "\n";'`
                # hashedMD5pass=`mkpasswd --method=md5  --salt=$saltvalue $rawpassword`
                 hashedMD5pass=`mkpasswd --method=md5 $rawpassword $(openssl rand -base64 16 | tr -d '+=' | head -c 8)`
                echo "Alas here it is "
                echo "The hashed password is ==> $hashedMD5pass "; break;;

                [2]*) echo " Case II sha512 detected"                
                echo "Calculating your hash sum..."
                echo $rawpassword
                # perl at the server has some locale warnings
                # hashedSHApass=`perl -e 'print crypt('$rawpassword', q($6$)), "\n";'`
                # hashedSHApass=`mkpasswd --method=sha-512 --salt=$saltvalue $rawpassword`
                hashedSHApass=`mkpasswd --method=sha-512 $rawpassword $(openssl rand -base64 16 | tr -d '+=' | head -c 8)`
                echo "Here is the sum ==> $hashedSHApass "; break ;;

                *) echo "All hashing algorithms functions"
                #hashedMD5pass=`perl -e 'print crypt('$rawpassword', q($1$)), "\n";'`
                hashedMD5pass=`mkpasswd --method=md5 --salt=$saltvalue $rawpassword`
                #hashedSHA1pass=`perl -e 'print crypt('$rawpassword', q($5$)), "\n";'`
                hashedSHA1pass=`mkpasswd --method=sha-256 --salt=$saltvalue $rawpassword`
                #hashedSHA2pass=`perl -e 'print crypt('$rawpassword', q($6$)), "\n";'`
                hashedSHA2pass=`mkpasswd --method=sha-512 --salt=$saltvalue $rawpassword`
                #Dispay all algorithms by default
                echo "The md5 version ==> $hashedMD5pass "
                echo "The sha256 version ==> $hashedSHA1pass "
                echo "The sha512 version is ==> $hashedSHA2pass "
                exit ;;
        esac
done
# the salt value i need to calculate my hashes is still unknown but ...



#Should i be able to append all the fields inside the shadow file or is it a must ??



#In order for me to be able to capture the white spaces in shell script input
# i need the following at usage

