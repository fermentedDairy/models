# Ollama Model Benchmark Results
Date: Sun Nov 22 19:21:39 UTC 2026
System Specs:
- CPU:                              AMD Ryzen 5 5500
- RAM: 30Gi
- OS: Linux 6.17.0-41-generic
- GPU: Intel Corporation Battlemage G21 [Intel Graphics]

Prompt: *"Write a short kotlin function that calculates the nth Fibonacci number. Use a recursive function without memoisation."*

## Models Benchmarked
| Model |
| :--- |
| fd-agents-A1-35B |
| fd-devstral-small-2-24b |
| fd-gpt-oss-20b |
| fd-ornith1.5-35b |
| fd-qwen3-coder-30b |
| fd-qwen3-coder-30b-base |
| fd-qwen3-coder-30b-ctx |
| fd-qwen3-coder-30b-ctx1 |
| fd-qwen3-coder-30b-ctx2 |
| fd-qwen3.5-4b |
| fd-qwen3.5-9b |
| fd-qwen3.8-27b-base |
| fd-qwen3.8-27b-bigC |
| fd-qwen3.8-27b-smallC |

Jitter is calculated as the difference between the maximum and minimum token rates observed across the benchmark runs.

### fd-agents-A1-35B

#### Model Statistics

```
NAME                       ID              SIZE     PROCESSOR    CONTEXT    RUNNER      UNTIL   
fd-agents-A1-35B:latest    2c143259d938    21 GB    100% GPU     16384      llamacpp    Forever    
```

| Run | Prompt Eval Time (s) | Prompt Eval Rate (tokens/s) | Eval Rate (tokens/s) | Total Tokens (tokens) |
| :--- | :--- | :--- | :--- | :--- |
| 1 | .691960 | 132.96 | 35.15 | 426 token(s) |
| 2 | .146182 | 27.36 | 50.68 | 273 token(s) |
| 3 | .229687 | 17.42 | 62.85 | 339 token(s) |
| Average | .3559 | 59.24 | 49.56 | 346 |

#### Performance Metrics
| Metric | Value |
| :--- | :--- |
| Min Token Rate (tokens/s) | 35.15 |
| Max Token Rate (tokens/s) | 62.85 |
| Jitter (tokens/s) | 27.70 |


### fd-devstral-small-2-24b

#### Model Statistics

```
NAME                              ID              SIZE     PROCESSOR    CONTEXT    RUNNER      UNTIL   
fd-devstral-small-2-24b:latest    5c7b2c839eec    20 GB    100% GPU     65536      llamacpp    Forever    
```

| Run | Prompt Eval Time (s) | Prompt Eval Rate (tokens/s) | Eval Rate (tokens/s) | Total Tokens (tokens) |
| :--- | :--- | :--- | :--- | :--- |
| 1 | .059878 | 384.11 | 26.90 | 168 token(s) |
| 2 | .040112 | 24.93 | 26.90 | 174 token(s) |
| 3 | .039466 | 25.34 | 26.88 | 174 token(s) |
| Average | .0464 | 144.79 | 26.89 | 172 |

#### Performance Metrics
| Metric | Value |
| :--- | :--- |
| Min Token Rate (tokens/s) | 26.88 |
| Max Token Rate (tokens/s) | 26.90 |
| Jitter (tokens/s) | .02 |


### fd-gpt-oss-20b

#### Model Statistics

```
NAME                     ID              SIZE     PROCESSOR    CONTEXT    RUNNER      UNTIL   
fd-gpt-oss-20b:latest    796b9c80857d    12 GB    100% GPU     65536      llamacpp    Forever    
```

| Run | Prompt Eval Time (s) | Prompt Eval Rate (tokens/s) | Eval Rate (tokens/s) | Total Tokens (tokens) |
| :--- | :--- | :--- | :--- | :--- |
| 1 | .233712 | 98.41 | 67.49 | 183 token(s) |
| 2 | .027547 | 36.30 | 67.43 | 256 token(s) |
| 3 | .027980 | 35.74 | 67.58 | 316 token(s) |
| Average | .0964 | 56.81 | 67.50 | 251 |

#### Performance Metrics
| Metric | Value |
| :--- | :--- |
| Min Token Rate (tokens/s) | 67.43 |
| Max Token Rate (tokens/s) | 67.58 |
| Jitter (tokens/s) | .15 |


### fd-ornith1.5-35b

#### Model Statistics

```
NAME                       ID              SIZE     PROCESSOR    CONTEXT    RUNNER      UNTIL   
fd-ornith1.5-35b:latest    bbebdea62c74    21 GB    100% GPU     16384      llamacpp    Forever    
```

| Run | Prompt Eval Time (s) | Prompt Eval Rate (tokens/s) | Eval Rate (tokens/s) | Total Tokens (tokens) |
| :--- | :--- | :--- | :--- | :--- |
| 1 | .406624 | 233.63 | 72.17 | 144 token(s) |
| 2 | .145742 | 27.45 | 71.97 | 247 token(s) |
| 3 | .142986 | 27.97 | 71.58 | 270 token(s) |
| Average | .2317 | 96.35 | 71.90 | 220 |

#### Performance Metrics
| Metric | Value |
| :--- | :--- |
| Min Token Rate (tokens/s) | 71.58 |
| Max Token Rate (tokens/s) | 72.17 |
| Jitter (tokens/s) | .59 |


### fd-qwen3-coder-30b

#### Model Statistics

```
NAME                         ID              SIZE     PROCESSOR    CONTEXT    RUNNER      UNTIL   
fd-qwen3-coder-30b:latest    9d7273b151f5    20 GB    100% GPU     32768      llamacpp    Forever    
```

| Run | Prompt Eval Time (s) | Prompt Eval Rate (tokens/s) | Eval Rate (tokens/s) | Total Tokens (tokens) |
| :--- | :--- | :--- | :--- | :--- |
| 1 | .203138 | 123.07 | 80.68 | 165 token(s) |
| 2 | .012722 | 78.60 | 81.02 | 165 token(s) |
| 3 | .012961 | 77.15 | 81.08 | 165 token(s) |
| Average | .0762 | 92.94 | 80.92 | 165 |

#### Performance Metrics
| Metric | Value |
| :--- | :--- |
| Min Token Rate (tokens/s) | 80.68 |
| Max Token Rate (tokens/s) | 81.08 |
| Jitter (tokens/s) | .40 |


### fd-qwen3-coder-30b-base

#### Model Statistics

```
NAME                              ID              SIZE     PROCESSOR    CONTEXT    RUNNER      UNTIL   
fd-qwen3-coder-30b-base:latest    70465b432715    20 GB    100% GPU     32768      llamacpp    Forever    
```

| Run | Prompt Eval Time (s) | Prompt Eval Rate (tokens/s) | Eval Rate (tokens/s) | Total Tokens (tokens) |
| :--- | :--- | :--- | :--- | :--- |
| 1 | .176124 | 141.95 | 81.06 | 176 token(s) |
| 2 | .012694 | 78.78 | 80.78 | 165 token(s) |
| 3 | .013971 | 71.58 | 80.66 | 187 token(s) |
| Average | .0675 | 97.43 | 80.83 | 176 |

#### Performance Metrics
| Metric | Value |
| :--- | :--- |
| Min Token Rate (tokens/s) | 80.66 |
| Max Token Rate (tokens/s) | 81.06 |
| Jitter (tokens/s) | .40 |


### fd-qwen3-coder-30b-ctx

#### Model Statistics

```
NAME                             ID              SIZE     PROCESSOR    CONTEXT    RUNNER      UNTIL   
fd-qwen3-coder-30b-ctx:latest    1033236d5206    22 GB    100% GPU     81920      llamacpp    Forever    
```

| Run | Prompt Eval Time (s) | Prompt Eval Rate (tokens/s) | Eval Rate (tokens/s) | Total Tokens (tokens) |
| :--- | :--- | :--- | :--- | :--- |
| 1 | .177123 | 141.14 | 80.71 | 175 token(s) |
| 2 | .013477 | 74.20 | 80.56 | 165 token(s) |
| 3 | .012716 | 78.64 | 80.54 | 187 token(s) |
| Average | .0677 | 97.99 | 80.60 | 175 |

#### Performance Metrics
| Metric | Value |
| :--- | :--- |
| Min Token Rate (tokens/s) | 80.54 |
| Max Token Rate (tokens/s) | 80.71 |
| Jitter (tokens/s) | .17 |


### fd-qwen3-coder-30b-ctx1

#### Model Statistics

```
NAME                              ID              SIZE     PROCESSOR    CONTEXT    RUNNER      UNTIL   
fd-qwen3-coder-30b-ctx1:latest    3e4e39593fb8    22 GB    100% GPU     65536      llamacpp    Forever    
```

| Run | Prompt Eval Time (s) | Prompt Eval Rate (tokens/s) | Eval Rate (tokens/s) | Total Tokens (tokens) |
| :--- | :--- | :--- | :--- | :--- |
| 1 | .186696 | 133.91 | 78.67 | 106 token(s) |
| 2 | .015601 | 64.10 | 77.70 | 106 token(s) |
| 3 | .019570 | 51.10 | 76.75 | 106 token(s) |
| Average | .0739 | 83.03 | 77.70 | 106 |

#### Performance Metrics
| Metric | Value |
| :--- | :--- |
| Min Token Rate (tokens/s) | 76.75 |
| Max Token Rate (tokens/s) | 78.67 |
| Jitter (tokens/s) | 1.92 |


### fd-qwen3-coder-30b-ctx2

#### Model Statistics

```
NAME                              ID              SIZE     PROCESSOR         CONTEXT    RUNNER      UNTIL   
fd-qwen3-coder-30b-ctx2:latest    9308ad89082a    23 GB    1%/99% CPU/GPU    90112      llamacpp    Forever    
```

| Run | Prompt Eval Time (s) | Prompt Eval Rate (tokens/s) | Eval Rate (tokens/s) | Total Tokens (tokens) |
| :--- | :--- | :--- | :--- | :--- |
| 1 | .181446 | 137.78 | 76.84 | 106 token(s) |
| 2 | .019876 | 50.31 | 75.74 | 106 token(s) |
| 3 | .015263 | 65.52 | 75.14 | 106 token(s) |
| Average | .0721 | 84.53 | 75.90 | 106 |

#### Performance Metrics
| Metric | Value |
| :--- | :--- |
| Min Token Rate (tokens/s) | 75.14 |
| Max Token Rate (tokens/s) | 76.84 |
| Jitter (tokens/s) | 1.70 |


### fd-qwen3.5-4b

#### Model Statistics

```
NAME                    ID              SIZE      PROCESSOR    CONTEXT    RUNNER      UNTIL   
fd-qwen3.5-4b:latest    7b7cae4d45bc    3.4 GB    100% GPU     16384      llamacpp    Forever    
```

| Run | Prompt Eval Time (s) | Prompt Eval Rate (tokens/s) | Eval Rate (tokens/s) | Total Tokens (tokens) |
| :--- | :--- | :--- | :--- | :--- |
| 1 | .098456 | 792.23 | 84.38 | 1228 token(s) |
| 2 | .058428 | 68.46 | 83.64 | 1823 token(s) |
| 3 | .055542 | 72.02 | 84.27 | 1121 token(s) |
| Average | .0708 | 310.90 | 84.09 | 1390 |

#### Performance Metrics
| Metric | Value |
| :--- | :--- |
| Min Token Rate (tokens/s) | 83.64 |
| Max Token Rate (tokens/s) | 84.38 |
| Jitter (tokens/s) | .74 |


### fd-qwen3.5-9b

#### Model Statistics

```
NAME                    ID              SIZE      PROCESSOR    CONTEXT    RUNNER      UNTIL   
fd-qwen3.5-9b:latest    2a5c36a62b7e    6.3 GB    100% GPU     32768      llamacpp    Forever    
```

| Run | Prompt Eval Time (s) | Prompt Eval Rate (tokens/s) | Eval Rate (tokens/s) | Total Tokens (tokens) |
| :--- | :--- | :--- | :--- | :--- |
| 1 | .198486 | 473.59 | 57.52 | 197 token(s) |
| 2 | .064144 | 62.36 | 57.50 | 210 token(s) |
| 3 | .061477 | 65.06 | 57.31 | 240 token(s) |
| Average | .1080 | 200.33 | 57.44 | 215 |

#### Performance Metrics
| Metric | Value |
| :--- | :--- |
| Min Token Rate (tokens/s) | 57.31 |
| Max Token Rate (tokens/s) | 57.52 |
| Jitter (tokens/s) | .21 |


### fd-qwen3.8-27b-base

#### Model Statistics

```
NAME                          ID              SIZE     PROCESSOR    CONTEXT    RUNNER      UNTIL   
fd-qwen3.8-27b-base:latest    8f4ec2e1840d    17 GB    100% GPU     32768      llamacpp    Forever    
```

| Run | Prompt Eval Time (s) | Prompt Eval Rate (tokens/s) | Eval Rate (tokens/s) | Total Tokens (tokens) |
| :--- | :--- | :--- | :--- | :--- |
| 1 | .537821 | 195.23 | 47.03 | 306 token(s) |
| 2 | .174484 | 22.92 | 46.92 | 275 token(s) |
| 3 | .167827 | 23.83 | 50.13 | 284 token(s) |
| Average | .2933 | 80.66 | 48.02 | 288 |

#### Performance Metrics
| Metric | Value |
| :--- | :--- |
| Min Token Rate (tokens/s) | 46.92 |
| Max Token Rate (tokens/s) | 50.13 |
| Jitter (tokens/s) | 3.21 |


### fd-qwen3.8-27b-bigC

#### Model Statistics

```
NAME                          ID              SIZE     PROCESSOR    CONTEXT    RUNNER      UNTIL   
fd-qwen3.8-27b-bigC:latest    12375b501946    18 GB    100% GPU     98304      llamacpp    Forever    
```

| Run | Prompt Eval Time (s) | Prompt Eval Rate (tokens/s) | Eval Rate (tokens/s) | Total Tokens (tokens) |
| :--- | :--- | :--- | :--- | :--- |
| 1 | .872206 | 120.38 | 37.45 | 454 token(s) |
| 2 | 1.001661 | 3.99 | 27.37 | 445 token(s) |
| 3 | .236446 | 16.92 | 46.21 | 587 token(s) |
| Average | .7034 | 47.09 | 37.01 | 495 |

#### Performance Metrics
| Metric | Value |
| :--- | :--- |
| Min Token Rate (tokens/s) | 27.37 |
| Max Token Rate (tokens/s) | 46.21 |
| Jitter (tokens/s) | 18.84 |


### fd-qwen3.8-27b-smallC

#### Model Statistics

```
NAME                            ID              SIZE     PROCESSOR    CONTEXT    RUNNER      UNTIL   
fd-qwen3.8-27b-smallC:latest    ccab35d7e9e8    17 GB    100% GPU     32768      llamacpp    Forever    
```

| Run | Prompt Eval Time (s) | Prompt Eval Rate (tokens/s) | Eval Rate (tokens/s) | Total Tokens (tokens) |
| :--- | :--- | :--- | :--- | :--- |
| 1 | .533539 | 196.80 | 51.02 | 192 token(s) |
| 2 | .175356 | 22.81 | 49.55 | 443 token(s) |
| 3 | .168984 | 23.67 | 51.30 | 474 token(s) |
| Average | .2926 | 81.09 | 50.62 | 369 |

#### Performance Metrics
| Metric | Value |
| :--- | :--- |
| Min Token Rate (tokens/s) | 49.55 |
| Max Token Rate (tokens/s) | 51.30 |
| Jitter (tokens/s) | 1.75 |


