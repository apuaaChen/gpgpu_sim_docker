# gpgpu_sim_docker
Docker file for GPGPU-Sim dev version, with ubuntu 16.04, CUDA 9.1

## Instructions
#### Install
**Step 1**: check if the docker image for ubuntu:16.04 exists with 
```
docker image ls
```
If it doesn't exists, pull it with
```
docker pull ubuntu:16.04
```

**Step 2**: download the "Dockerfile", navigate to the directory where you store it, and build the image with
```
docker build -t image_name .
```
The building process may take around 1 hour, for it has to download and install the CUDA Toolkit.

**Step 3**: create a container of the image with
```
docker run -v host_dir:container_dir -it --name container_name image_name
```
After entering the container, the GPGPU-Sim can be built with the commands as follows
```
source setup_environment
make
```
To verify whether gpgpu-sim is successfully setup, use
```
echo $LD_LIBRARY_PATH
```
and you are expected to get
```
/home/gpgpu_sim/gpgpu-sim_distribution/lib/gcc-5.4.0/cuda-9010/release
```
```

