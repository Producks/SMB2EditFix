all:
	g++ -std=c++20 -Wall -Werror -Wextra -Wpedantic -Wshadow -O2 *.cpp -o smb2fix

test: all
	cd ../smb2edit-replica && ./build.sh -dSMBEDIT && hexdump -C ./bin/smb2.nes > rec && diff rec edit > result.txt && cat result.txt && cd ../smb2fix && ./smb2fix ../smb2edit-replica/bin/smb2.nes