if [[ $(uname) == "Darwin" ]]; then
        if [[ $(uname -m) == "arm64" ]]; then
            curl -L https://apt.procurs.us/bootstraps/big_sur/bootstrap-darwin-arm64.tar.zst -o bootstrap.tar.zst
        else
            curl -L https://apt.procurs.us/bootstraps/big_sur/bootstrap-darwin-amd64.tar.zst -o bootstrap.tar.zst
        fi
        curl -LO https://cameronkatri.com/zstd
        chmod +x zstd
        ./zstd -d bootstrap.tar.zst
        rm -rfv /opt/procursus
        tar -xpkf bootstrap.tar -C /
        mv zstd /opt/procursus/bin/zstd
        printf 'export PATH="/opt/procursus/bin:/opt/procursus/sbin:/opt/procursus/games:$PATH"\nexport CPATH="$CPATH:/opt/procursus/include"\nexport LIBRARY_PATH="$LIBRARY_PATH:/opt/procursus/lib"\n' | sudo tee -a /etc/zshenv /etc/profile 
        export PATH="/opt/procursus/bin:/opt/procursus/sbin:/opt/procursus/games:$PATH"
        export CPATH="$CPATH:/opt/procursus/include"
        export LIBRARY_PATH="$LIBRARY_PATH:/opt/procursus/lib"
        echo >> ~/.zprofile #this fix for apt on macos was taken from azaz, thank you!
        echo PATH="/opt/procursus/bin:/opt/procursus/sbin:/opt/procursus/games:$PATH" >> ~/.zprofile
        echo CPATH="$CPATH:/opt/procursus/include" >> ~/.zprofile
        echo PATH="/opt/procursus/bin:/opt/procursus/sbin:/opt/procursus/games:$PATH" >> ~/.zprofile
        echo CPATH="$CPATH:/opt/procursus/include" >> ~/.zprofile
        echo LIBRARY_PATH="$LIBRARY_PATH:/opt/procursus/lib" >> ~/.zprofile
        echo export PATH >> ~/.zprofile
        echo export CPATH >> ~/.zprofile
        echo export LIBRARY_PATH >> ~/.zprofile
        source ~/.zprofile
        #update and install sileo
        apt update
        apt full-upgrade -y --allow-downgrades
        apt install sileo -y
        rm bootstrap.tar.zst bootstrap.tar
        echo "Installation Complete! Be sure to restart your terminal!"
