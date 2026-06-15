import json


def waybar(text: str, tooltip: str = "", class_name: str | None = None):
    payload = {
        "text": text,
        "tooltip": tooltip,
    }

    if class_name:
        payload["class"] = class_name

    print(json.dumps(payload, ensure_ascii=False), flush=True)
