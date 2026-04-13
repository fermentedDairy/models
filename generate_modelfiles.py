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

    for key, model_list in data.items():
        if isinstance(model_list, list) and all(isinstance(item, dict) and "model-name" in item for item in model_list):
            model_key_dir = key.replace("-", "") # Attempt to clean up key for directory name
            if model_key_dir == "ollama" or model_key_dir == "docker":
                output_dir = f"./{model_key_dir}"
            else:
                output_dir = f"./{model_key_dir}"
            
            if not os.path.exists(output_dir):
                os.makedirs(output_dir)

            print(f"--- Processing section: {key} ---")

            for model_data in model_list:
                model_name = model_data["model-name"]
                base_model = model_data["base-model"]
                system_prompt = model_data["system-prompt"]
                params = model_data.get("parameters", {})

                modelfile_content = f"FROM {base_model}\n\n"
                
                if system_prompt:
                    modelfile_content += f"SYSTEM \"{system_prompt}\"\n\n"

                for key_param, value in params.items():
                    modelfile_content += f"PARAMETER {key_param} {value}\n"
                        
                output_filepath = os.path.join(output_dir, f"{model_name}-Modelfile")
                
                with open(output_filepath, 'w') as f:
                    f.write(modelfile_content)
                
                print(f"Successfully generated {output_filepath}")

if __name__ == "__main__":
    models_json = "./models.json"
    ollama_directory = "./ollama"
    generate_modelfiles(models_json, ollama_directory)