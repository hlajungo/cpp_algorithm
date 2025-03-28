#include "UseCudaLib.h"

bool Use_cuda::get_has_gpu()
{
  return has_gpu;
}

Use_cuda::Use_cuda() : has_gpu(false)
{
  if (is_has_gpu())
  {
    set_has_gpu(true);
  }
}

void Use_cuda::set_has_gpu(bool val)
{
  has_gpu = val;
}

bool Use_cuda::is_has_gpu()
{
  int device_count = 0;
  cudaError_t err = cudaGetDeviceCount(&device_count);

  if (err != cudaSuccess)
  {
    std::cerr << "CUDA error: " << cudaGetErrorString(err) << std::endl;
    return false;
  }

  return device_count > 0;
}
