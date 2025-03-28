#pragma once
#include <iostream>
#include <type_traits>
#include <cuda_runtime.h>

// 父類：控制是否使用 CUDA
/**
 * @class Use_cuda
 * @brief 檢測並管理 CUDA 設備的使用。
 */
class Use_cuda {
  public:
    /**
     * @brief 獲取當前系統是否有 GPU。
     * @return 如果有可用的 GPU，返回 true，否則返回 false。
     */
    bool get_has_gpu();
  protected:
    /**
     * @brief 構造函數，初始化 GPU 檢測。
     */
    Use_cuda();
  private:
    bool has_gpu; ///< 是否有 GPU
    /**
     * @brief 設定 GPU 狀態。
     * @param val 設置值
     */
    void set_has_gpu(bool val);
    /**
     * @brief 檢測是否有 GPU 設備。
     * @return 如果有 GPU，返回 true，否則返回 false。
     */
    bool is_has_gpu();
};
