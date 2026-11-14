# Ollama Model Benchmark Results
Date: Fri Nov 13 22:21:57 UTC 2026
System Specs:
- CPU:                              AMD Ryzen 5 5500
- RAM: 30Gi
- OS: Linux 6.17.0-41-generic
- GPU: Intel Corporation Battlemage G21 [Intel Graphics]

Prompt: *"Write a short kotlin function that calculates the nth Fibonacci number. Use a recursive function without memoisation."*

### Models Benchmarked
- fd-flint-40b
- fd-gemma4-12b
- fd-gemma4-26b
- fd-gemma4-26b-q8
- fd-gemma4-31b
- fd-gemma4-e4b
- fd-ornith-35b
- fd-ornith-9b
- fd-qwen2.5-coder-14b
- fd-qwen2.5-coder-32b
- fd-qwen3-4b
- fd-qwen3-coder-30b
- fd-qwen3.5-27b
- fd-qwen3.5-4b
- fd-qwen3.5-9b
- fd-qwen3.6-35b

## Run 1
| Model | TTFT (s) | Tokens/sec | Total Tokens |
| :--- | :--- | :--- | :--- |
| fd-flint-40b | .4687 | 5.65 | 552 |
| fd-gemma4-12b | .4404 | 42.11 | 598 |
| fd-gemma4-26b | .3378 | 47.07 | 563 |
| fd-gemma4-26b-q8 | 5.4314 | 14.99 | 658 |
| fd-gemma4-31b | 1.4366 | 8.18 | 467 |
| fd-gemma4-e4b | 1.5060 | 157.74 | 937 |
| fd-ornith-35b | .4092 | 38.13 | 702 |
| fd-ornith-9b | .6618 | 59.53 | 181 |
| fd-qwen2.5-coder-14b | .0507 | 39.62 | 168 |
| fd-qwen2.5-coder-32b | .2327 | 13.10 | 303 |
| fd-qwen3-4b | .0216 | 86.24 | 2952 |
| fd-qwen3-coder-30b | .2089 | 78.92 | 191 |
| fd-qwen3.5-27b | .2293 | 21.05 | 308 |
| fd-qwen3.5-4b | .0680 | 84.14 | 2117 |
| fd-qwen3.5-9b | .0799 | 57.00 | 2657 |
| fd-qwen3.6-35b | .3307 | 26.06 | 1301 |

## Run 2
| Model | TTFT (s) | Tokens/sec | Total Tokens |
| :--- | :--- | :--- | :--- |
| fd-flint-40b | .4719 | 35.48 | 483 |
| fd-gemma4-12b | .3726 | 42.33 | 555 |
| fd-gemma4-26b | .4269 | 22.96 | 628 |
| fd-gemma4-26b-q8 | 5.0838 | 19.60 | 662 |
| fd-gemma4-31b | 1.4819 | 4.34 | 481 |
| fd-gemma4-e4b | .6679 | 154.66 | 829 |
| fd-ornith-35b | .3998 | 71.02 | 505 |
| fd-ornith-9b | 1.7847 | 20.26 | 123 |
| fd-qwen2.5-coder-14b | .0465 | 39.63 | 174 |
| fd-qwen2.5-coder-32b | .2547 | 7.68 | 233 |
| fd-qwen3-4b | .0186 | 95.20 | 397 |
| fd-qwen3-coder-30b | .1756 | 79.09 | 193 |
| fd-qwen3.5-27b | .9688 | 10.68 | 369 |
| fd-qwen3.5-4b | .0665 | 84.33 | 603 |
| fd-qwen3.5-9b | .0801 | 57.26 | 1659 |
| fd-qwen3.6-35b | 1.0667 | 8.99 | 1580 |

## Run 3
| Model | TTFT (s) | Tokens/sec | Total Tokens |
| :--- | :--- | :--- | :--- |
| fd-flint-40b | .5194 | 35.54 | 359 |
| fd-gemma4-12b | .4024 | 17.81 | 435 |
| fd-gemma4-26b | .4197 | 46.79 | 694 |
| fd-gemma4-26b-q8 | 7.4928 | 17.25 | 502 |
| fd-gemma4-31b | 1.7551 | 8.18 | 473 |
| fd-gemma4-e4b | .7710 | 155.73 | 883 |
| fd-ornith-35b | .5660 | 72.00 | 782 |
| fd-ornith-9b | 1.4804 | 39.37 | 152 |
| fd-qwen2.5-coder-14b | .0431 | 39.69 | 181 |
| fd-qwen2.5-coder-32b | .2278 | 14.01 | 277 |
| fd-qwen3-4b | .0190 | 87.27 | 2847 |
| fd-qwen3-coder-30b | .1747 | 78.48 | 186 |
| fd-qwen3.5-27b | .2208 | 11.11 | 201 |
| fd-qwen3.5-4b | .0657 | 83.01 | 3539 |
| fd-qwen3.5-9b | .0799 | 57.52 | 302 |
| fd-qwen3.6-35b | .4815 | 13.26 | 1158 |

