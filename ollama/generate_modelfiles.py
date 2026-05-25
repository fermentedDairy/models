import json
import os

def generate_modelfiles(models_json_path: str, ollama_dir: str):
    """
    Reads model definitions from a JSON file and generates corresponding Ollama Modelfiles.
    """
    try:
        with open(models_json_path, 'r') as f:
            data = json.load(f)
    except FileNotFoundError:
        print(f"Error: The file {models_json_path} was not found.")
        return
    except json.JSONDecodeError:
        print(f"Error: Could not decode JSON from {models_json_path}.")
        return

    output_dir = "./modelfiles"

    if not os.path.exists(output_dir):
                os.makedirs(output_dir)

    for model_list in data:
                model_name = model_list["model-name"]
                base_model = model_list["base-model"]
                system_prompt = model_list.get("system-prompt")
                params = model_list.get("parameters", {})

                modelfile_content = f"FROM {base_model}\n\n"
                
                if system_prompt:
                    modelfile_content += f"SYSTEM \"{system_prompt}\"\n\n"

                for key_param, value in params.items():
                    if isinstance(value, list):
                        for item in value:
                            modelfile_content += f"PARAMETER {key_param} {item}\n"
                    else:
                        modelfile_content += f"PARAMETER {key_param} {value}\n"
                        
                output_filepath = os.path.join(output_dir, f"{model_name}-Modelfile")
                
                with open(output_filepath, 'w') as f:
                    f.write(modelfile_content)
                
                print(f"Successfully generated {output_filepath}")

if __name__ == "__main__":
    models_json = "./models.json"
    ollama_directory = "./ollama"
    generate_modelfiles(models_json, ollama_directory)