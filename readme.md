 # LLM customisation
Repo containing info for customising LLMs.

## Ollama

### Defining models
Add the models to the [./ollama/models.json](./ollama/models.json) files, only the base model name and the new model name are required, 
it is recomended that a custom context size is specified to get the best performance for the particular hardware setup.

### How to create ollama models
- add the model detail to the list in the `models.json` file. 
- run `. ollama/create_ollama_models.sh`
 