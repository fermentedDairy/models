# Ollama Model Benchmark Results
Date: Sat Nov 21 06:58:12 UTC 2026
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
| fd-qwen3-coder-30b-ctx |
| fd-qwen3.5-4b |
| fd-qwen3.5-9b |

Jitter is calculated as the difference between the maximum and minimum token rates observed across the benchmark runs.

### fd-agents-A1-35B

#### Model Statistics

```
NAME                       ID              SIZE     PROCESSOR    CONTEXT    RUNNER      UNTIL   
fd-agents-A1-35B:latest    2c143259d938    21 GB    100% GPU     16384      llamacpp    Forever    
```

| Run | Prompt Eval Time (s) | Prompt Eval Rate (tokens/s) | Eval Rate (tokens/s) | Total Tokens (tokens) |
| :--- | :--- | :--- | :--- | :--- |
| 1 | .416521 | 220.88 | 47.47 | 598 token(s) |
| 2 | .209439 | 19.10 | 45.98 | 530 token(s) |
| 3 | .251665 | 15.89 | 56.40 | 223 token(s) |
| Average | .2925 | 85.29 | 49.95 | 450 |

#### Performance Metrics
| Metric | Value |
| :--- | :--- |
| Min Token Rate (tokens/s) | 45.98 |
| Max Token Rate (tokens/s) | 56.40 |
| Jitter (tokens/s) | 10.42 |


### fd-devstral-small-2-24b

#### Model Statistics

```
NAME                              ID              SIZE     PROCESSOR    CONTEXT    RUNNER      UNTIL   
fd-devstral-small-2-24b:latest    5c7b2c839eec    20 GB    100% GPU     65536      llamacpp    Forever    
```

| Run | Prompt Eval Time (s) | Prompt Eval Rate (tokens/s) | Eval Rate (tokens/s) | Total Tokens (tokens) |
| :--- | :--- | :--- | :--- | :--- |
| 1 | .078124 | 294.40 | 2.80 | 175 token(s) |
| 2 | .043360 | 23.06 | 4.19 | 212 token(s) |
| 3 | .038574 | 25.92 | 26.83 | 174 token(s) |
| Average | .0533 | 114.46 | 11.27 | 187 |

#### Performance Metrics
| Metric | Value |
| :--- | :--- |
| Min Token Rate (tokens/s) | 2.80 |
| Max Token Rate (tokens/s) | 26.83 |
| Jitter (tokens/s) | 24.03 |


### fd-gpt-oss-20b

#### Model Statistics

```
NAME                     ID              SIZE     PROCESSOR    CONTEXT    RUNNER      UNTIL   
fd-gpt-oss-20b:latest    796b9c80857d    12 GB    100% GPU     65536      llamacpp    Forever    
```

| Run | Prompt Eval Time (s) | Prompt Eval Rate (tokens/s) | Eval Rate (tokens/s) | Total Tokens (tokens) |
| :--- | :--- | :--- | :--- | :--- |
| 1 | .315647 | 72.87 | 7.49 | 271 token(s) |
| 2 | .022446 | 44.55 | 59.54 | 267 token(s) |
| 3 | .023599 | 42.37 | 39.30 | 228 token(s) |
| Average | .1205 | 53.26 | 35.44 | 255 |

#### Performance Metrics
| Metric | Value |
| :--- | :--- |
| Min Token Rate (tokens/s) | 7.49 |
| Max Token Rate (tokens/s) | 59.54 |
| Jitter (tokens/s) | 52.05 |


### fd-ornith1.5-35b

#### Model Statistics

```
NAME                       ID              SIZE     PROCESSOR    CONTEXT    RUNNER      UNTIL   
fd-ornith1.5-35b:latest    bbebdea62c74    21 GB    100% GPU     16384      llamacpp    Forever    
```

| Run | Prompt Eval Time (s) | Prompt Eval Rate (tokens/s) | Eval Rate (tokens/s) | Total Tokens (tokens) |
| :--- | :--- | :--- | :--- | :--- |
| 1 | .400454 | 237.23 | 71.64 | 147 token(s) |
| 2 | .218303 | 18.32 | 71.93 | 199 token(s) |
| 3 | .143968 | 27.78 | 71.87 | 254 token(s) |
| Average | .2542 | 94.44 | 71.81 | 200 |

#### Performance Metrics
| Metric | Value |
| :--- | :--- |
| Min Token Rate (tokens/s) | 71.64 |
| Max Token Rate (tokens/s) | 71.93 |
| Jitter (tokens/s) | .29 |


### fd-qwen3-coder-30b

#### Model Statistics

```
NAME                         ID              SIZE     PROCESSOR    CONTEXT    RUNNER      UNTIL   
fd-qwen3-coder-30b:latest    899e1c042be1    20 GB    100% GPU     32768      llamacpp    Forever    
```

| Run | Prompt Eval Time (s) | Prompt Eval Rate (tokens/s) | Eval Rate (tokens/s) | Total Tokens (tokens) |
| :--- | :--- | :--- | :--- | :--- |
| 1 | .187300 | 133.48 | 78.84 | 106 token(s) |
| 2 | .015617 | 64.03 | 78.37 | 106 token(s) |
| 3 | .016903 | 59.16 | 77.67 | 123 token(s) |
| Average | .0732 | 85.55 | 78.29 | 111 |

#### Performance Metrics
| Metric | Value |
| :--- | :--- |
| Min Token Rate (tokens/s) | 77.67 |
| Max Token Rate (tokens/s) | 78.84 |
| Jitter (tokens/s) | 1.17 |


### fd-qwen3-coder-30b-ctx

#### Model Statistics

```
NAME                             ID              SIZE     PROCESSOR    CONTEXT    RUNNER      UNTIL   
fd-qwen3-coder-30b-ctx:latest    46e44bfda0d1    21 GB    100% GPU     49152      llamacpp    Forever    
```

| Run | Prompt Eval Time (s) | Prompt Eval Rate (tokens/s) | Eval Rate (tokens/s) | Total Tokens (tokens) |
| :--- | :--- | :--- | :--- | :--- |
| 1 | .182507 | 136.98 | 78.56 | 106 token(s) |
| 2 | .015334 | 65.21 | 78.35 | 106 token(s) |
| 3 | .016942 | 59.02 | 77.86 | 106 token(s) |
| Average | .0715 | 87.07 | 78.25 | 106 |

#### Performance Metrics
| Metric | Value |
| :--- | :--- |
| Min Token Rate (tokens/s) | 77.86 |
| Max Token Rate (tokens/s) | 78.56 |
| Jitter (tokens/s) | .70 |


### fd-qwen3.5-4b

#### Model Statistics

```
NAME                    ID              SIZE      PROCESSOR    CONTEXT    RUNNER      UNTIL   
fd-qwen3.5-4b:latest    7b7cae4d45bc    3.4 GB    100% GPU     16384      llamacpp    Forever    
```

| Run | Prompt Eval Time (s) | Prompt Eval Rate (tokens/s) | Eval Rate (tokens/s) | Total Tokens (tokens) |
| :--- | :--- | :--- | :--- | :--- |
| 1 | .087693 | 889.47 | 84.22 | 992 token(s) |
| 2 | .062175 | 64.33 | 83.91 | 721 token(s) |
| 3 | .055789 | 71.70 | 83.65 | 934 token(s) |
| Average | .0685 | 341.83 | 83.92 | 882 |

#### Performance Metrics
| Metric | Value |
| :--- | :--- |
| Min Token Rate (tokens/s) | 83.65 |
| Max Token Rate (tokens/s) | 84.22 |
| Jitter (tokens/s) | .57 |


### fd-qwen3.5-9b

#### Model Statistics

```
NAME                    ID              SIZE      PROCESSOR    CONTEXT    RUNNER      UNTIL   
fd-qwen3.5-9b:latest    2a5c36a62b7e    6.3 GB    100% GPU     32768      llamacpp    Forever    
```

| Run | Prompt Eval Time (s) | Prompt Eval Rate (tokens/s) | Eval Rate (tokens/s) | Total Tokens (tokens) |
| :--- | :--- | :--- | :--- | :--- |
| 1 | .315889 | 297.57 | 57.41 | 172 token(s) |
| 2 | .068642 | 58.27 | 57.26 | 194 token(s) |
| 3 | .061533 | 65.01 | 57.27 | 165 token(s) |
| Average | .1486 | 140.28 | 57.31 | 177 |

#### Performance Metrics
| Metric | Value |
| :--- | :--- |
| Min Token Rate (tokens/s) | 57.26 |
| Max Token Rate (tokens/s) | 57.41 |
| Jitter (tokens/s) | .15 |


