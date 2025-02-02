sudo systemctl status kmsconvt@tty3.service
sudo systemctl restart kmsconvt@tty3.service
sudo systemctl stop getty4.service
sudo systemctl stop getty@tty4.service
systemctl stop kmsconvt@tty5.service
git submodule update --init --recursive
CXXFLAGS=-pg CFLAGS=-pg cmake .. -DCMAKE_BUILD_TYPE=Debug -DHEADLESS_CLIENT=ON -DCURSES_CLIENT=ON
cmake --build . --config Debug --target everything -- -k 0
cmake .. -DCMAKE_BUILD_TYPE=RelWithDebInfo -DHEADLESS_CLIENT=ON -DCURSES_CLIENT=ON
cmake .. -DCMAKE_CXX_COMPILER_LAUNCHER=ccache
cmake .. -DCMAKE_EXPORT_COMPILE_COMMANDS=1
cmake .. -DCMAKE_CXX_FLAGS=-rdynamic
cmake .. -DDOWNLOAD_GTEST=ON && make run_tests -j12
cmake .. -DCMAKE_TESTING_ENABLED=ON && GTEST_BRIEF=1 make run_tests -j12
cmake .. -DCMAKE_CXX_CLANG_TIDY="clang-tidy;-warnings-as-errors=*" -DCMAKE_C_CLANG_TIDY="clang-tidy;-warnings-as-errors=*" -DCMAKE_BUILD_TYPE=Debug -Werror=dev
zbarimg -q --raw qrcode.png | pass otp insert totp-secret
rsync --info=progress2 -r chiller@zillyhuhn.com:/tmp/foo .
sudo tcpdump -i lo "port 8303" -w debug.pcap
./DDNet "connect tw-0.7+udp://127.0.0.1"
ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null root@github.com
mkdir build && cd build && cmake -DCMAKE_BUILD_TYPE=Release -DLLVM_ENABLE_PROJECTS="clang;clang-tools-extra" -G Ninja ../llvm/
git checkout -b pr_07_client_b76
perl -i -p -e's/\bm_paPlayerInfosRace\b/m_apPlayerInfosRace/g' $(find . -name *.cpp)
./DDNet ~/.teeworlds/demos/auto/$(ls --sort=time ~/.teeworlds/demos/auto/ | head -n1)
all_dirs "unzip *.zip; rm *.zip"
7za a foo.zip foo.txt -tzip -mem=AES256 -mx9 -p"$(read -rs a;printf %s "$a")"
./DDNet-Server "sv_map DDNetPP-maps/BlmapChill"
find . -name "*.sh" -print0 | xargs -0 shfmt -d
python3 ~/Desktop/git/maps-scripts/BlmapChill/print_version.py BlmapChill.map
cd ~/.teeworlds/skins7 && for x in yeetswarb.json yeebbarb.json yeegsharp.json yeetcarb.json yeedbab.json; do cp greensward.json "$x"; done
cd ~/Desktop/git/twnet_parser/ && source venv/bin/activate && cd examples/07/flood && ./flood.py localhost 8303 10
./DDNet-Server "sv_map tmp/bridge;sv_gametype zCatch"
