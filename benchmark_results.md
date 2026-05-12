# Ollama Model Benchmark Results
Date: Tue May 12 15:46:32 UTC 2026
System Specs:
- CPU:                              AMD Ryzen 5 5500
- RAM: 30Gi
- OS: Linux 6.17.0-23-generic
- GPU: NVIDIA Corporation GA106 [GeForce RTX 3060 Lite Hash Rate] (rev a1)

Prompt: *"Write a short kotlin function that calculates the nth Fibonacci number. Use a recursive function without memoisation."*

## Run 1
| Model | TTFT (s) | Tokens/sec | Total Tokens |
| :--- | :--- | :--- | :--- |
| fd-gemma4-26b | .2799 | 20.56 | 657 |
| fd-gemma4-26b-q8 | .3899 | 12.42 | 524 |
| fd-gemma4-31b | 2.4609 | 2.97 | 621 |
| fd-gemma4-e4b | .0269 | 76.24 | 475 |
| fd-qwen3-4b | .2616 | 17.67 | 4601 |
| fd-qwen3.5-27b | 2.1047 | 3.18 | 186 |
| fd-qwen3.5-4b | .0388 | 66.81 | 2326 |
| fd-qwen3.5-9b | .0519 | 46.90 | 235 |
| fd-qwen3.6-35b | .4420 | 11.59 | 1580 |

## Run 2
| Model | TTFT (s) | Tokens/sec | Total Tokens |
| :--- | :--- | :--- | :--- |
| fd-gemma4-26b | .2751 | 21.32 | 549 |
| fd-gemma4-26b-q8 | .3897 | 12.37 | 583 |
| fd-gemma4-31b | 2.4698 | 3.01 | 429 |
| fd-gemma4-e4b | .0270 | 76.15 | 444 |
| fd-qwen3-4b | .2617 | 19.24 | 3510 |
| fd-qwen3.5-27b | 2.1088 | 3.18 | 223 |
| fd-qwen3.5-4b | .0395 | 67.46 | 255 |
| fd-qwen3.5-9b | .0507 | 46.81 | 265 |
| fd-qwen3.6-35b | .4473 | 11.60 | 1670 |

## Run 3
| Model | TTFT (s) | Tokens/sec | Total Tokens |
| :--- | :--- | :--- | :--- |
| fd-gemma4-26b | .2721 | 21.13 | 657 |
| fd-gemma4-26b-q8 | .3943 | 12.38 | 567 |
| fd-gemma4-31b | 2.4681 | 2.96 | 683 |
| fd-gemma4-e4b | .0268 | 75.80 | 567 |
| fd-qwen3-4b | .2614 | 16.34 | 5608 |
| fd-qwen3.5-27b | 2.0740 | 3.17 | 186 |
| fd-qwen3.5-4b | .0395 | 67.54 | 306 |
| fd-qwen3.5-9b | .0508 | 46.49 | 1762 |
| fd-qwen3.6-35b | .4428 | 11.56 | 1485 |

