if [ -f "/usr/local/bin/brew" ]
then
echo ""
else
echo "Installing brew"
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi
echo "Installing dependencies.."
brew install libimobiledevice
brew install ideviceinstaller
echo "Fixing stuff..."
cd /usr/local/opt/openssl/lib/

# You need root to do this
# rhcp011235@me.com
# http://twitter.com/john011235
sudo mkdir -p /opt/local/lib/
sudo cp libcrypto*dylib /opt/local/lib/

echo "Downloading latest futurerestore..."
mkdir ~/.futurerestore
curl -o ~/.futurerestore/futurerestore.zip http://api.tihmstar.net/builds/futurerestore/futurerestore-latest.zip
cd ~/.futurerestore
unzip futurerestore.zip
chmod 775 futurerestore_macos
mv futurerestore_macos /usr/local/bin/futurerestore
echo "Cleaning up..."
cd ..
rm -rf .futurerestore
echo "Done"

