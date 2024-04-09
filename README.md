# chembl_beaker

这个是[molOCR化学结构式识别](https://github.com/def-fun/molOCR)
的后端，在[chembl_beaker](https://github.com/chembl/chembl_beaker)的基础上修改

部署方式如下：

```shell
# install docker on your linux machine
sudo snap install docker

# download
wget https://github.com/def-fun/chembl_beaker/archive/refs/heads/master.zip
unzip chembl_beaker-master.zip

# build and run
cd chembl_beaker-master
sudo docker build -f Dockerfile -t my_chembl_beaker:v1.2 .
sudo docker run -p 5000:5000 my_chembl_beaker:v1.2

# backup
#sudo docker save -o my_chembl_beaker-v1.2.tar my_chembl_beaker:v1.2
sudo docker save 722c1891ce36 > my_chembl_beaker-v1.2.tar 
7z a -mx9 my_chembl_beaker-v1.2.tar.7z my_chembl_beaker-v1.2.tar

# check size and sha1sum
# my_chembl_beaker-v1.2.tar.7z    922M    de78350d2db6c7a2a1f3f9a4b86195466a3437ef
# my_chembl_beaker-v1.2.tar       3.1G    338d26ab0ccee04e661d74c9975641e5adbaa592

# restore
docker load -i my_chembl_beaker-v1.2.tar
```

在Ubuntu 22.04.3 LTS上测试通过
