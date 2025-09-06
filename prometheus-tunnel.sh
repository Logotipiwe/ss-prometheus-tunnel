if [ -z "$1" ]; then
  echo "Error: basic password should be given as first argument."
  exit 1
fi

docker compose down

mkdir -p ssh
rm -f ssh/tunnel-rsa ssh/tunnel-rsa.pub
ssh-keygen -f ssh/tunnel-rsa -N ""
cat ssh/tunnel-rsa.pub >> ~/.ssh/authorized_keys

sudo apt-get install apache2 -y
sudo htpasswd -bc .htpasswd prometheus-user $1
echo "=====Basic nginx password $1 for user prometheus-user created.======"

docker compose up -d