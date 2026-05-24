# Ollama Model Benchmark Results
Date: Wed May 20 19:55:53 SAST 2026
System Specs:
- CPU:                              AMD Ryzen 5 5500
- RAM: 30Gi
- OS: Linux 6.17.0-23-generic
- GPU: NVIDIA Corporation GA106 [GeForce RTX 3060 Lite Hash Rate] (rev a1)

Prompt: *"Write a short kotlin function that calculates the nth Fibonacci number. Use a recursive function without memoisation."*

### Models Benchmarked
- fd-gemma4-26b
- fd-gemma4-26b-q8
- fd-gemma4-31b
- fd-gemma4-e4b
- fd-qwen3-4b
- fd-qwen3-coder-30b
- fd-qwen3.5-27b
- fd-qwen3.5-4b
- fd-qwen3.5-9b
- fd-qwen3.6-35b

## Run 1
| Model | TTFT (s) | Tokens/sec | Total Tokens |
| :--- | :--- | :--- | :--- |
| fd-gemma4-26b | .2653 | 21.40 | 537 |
| fd-gemma4-26b-q8 | .4005 | 12.35 | 579 |
| fd-gemma4-31b | 2.5008 | 2.97 | 651 |
| fd-gemma4-e4b | .0277 | 75.40 | 892 |
| fd-qwen3-4b | .2612 | 24.80 | 691 |
| fd-qwen3-coder-30b | .2671 | 31.40 | 157 |
| fd-qwen3.5-27b | 2.0706 | 3.17 | 392 |
| fd-qwen3.5-4b | .0389 | 67.32 | 542 |
| fd-qwen3.5-9b | .0487 | 46.84 | 393 |
| fd-qwen3.6-35b | .4420 | 11.63 | 1464 |

## Run 2
| Model | TTFT (s) | Tokens/sec | Total Tokens |
| :--- | :--- | :--- | :--- |
| fd-gemma4-26b | .2849 | 20.69 | 545 |
| fd-gemma4-26b-q8 | .3899 | 12.44 | 520 |
| fd-gemma4-31b | 2.4793 | 2.97 | 625 |
| fd-gemma4-e4b | .0272 | 75.09 | 980 |
| fd-qwen3-4b | .2633 | 17.45 | 4719 |
| fd-qwen3-coder-30b | .2672 | 31.40 | 157 |
| fd-qwen3.5-27b | 2.0778 | 3.18 | 186 |
| fd-qwen3.5-4b | .0377 | 67.85 | 323 |
| fd-qwen3.5-9b | .0504 | 46.99 | 164 |
| fd-qwen3.6-35b | .4409 | 11.62 | 1583 |

## Run 3
| Model | TTFT (s) | Tokens/sec | Total Tokens |
| :--- | :--- | :--- | :--- |
| fd-gemma4-26b | .2821 | 20.66 | 569 |
| fd-gemma4-26b-q8 | .3866 | 12.38 | 516 |
| fd-gemma4-31b | 2.4723 | 2.99 | 538 |
| fd-gemma4-e4b | .0273 | 75.03 | 1157 |
| fd-qwen3-4b | .2614 | 25.32 | 504 |
| fd-qwen3-coder-30b | .2636 | 31.40 | 157 |
| fd-qwen3.5-27b | 2.0752 | 3.18 | 186 |
| fd-qwen3.5-4b | .0388 | 66.57 | 3464 |
| fd-qwen3.5-9b | .0499 | 46.80 | 351 |
| fd-qwen3.6-35b | .4413 | 11.68 | 1279 |

