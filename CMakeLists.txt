

cmake_minimum_required(VERSION 3.0)
project(HelloCuda)


FIND_PACKAGE(CUDA REQUIRED)


set(CUDA_NVCC_FLAGS ${CUDA_NVCC_FLAGS} -gencode arch=compute_20,code=sm_20)


cuda_add_executable(hellocuda
    src/main.cu
)


install(TARGETS hellocuda DESTINATION bin)