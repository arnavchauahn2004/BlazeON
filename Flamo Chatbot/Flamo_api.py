from flask import Flask, request, jsonify
import google.generativeai as genai
import os

app = Flask(__name__)

# 🔐 Replace with your actual Gemini API key or set it as an environment variable
GEMINI_API_KEY = os.getenv("GEMINI_API_KEY", "AIzaSyBwkZxUsdQX_sfUpfaJbMsKt2P9i4uhL14")
genai.configure(api_key=GEMINI_API_KEY)

# 🔥 Create chat sessions dictionary to maintain history per session (optional)
chat_sessions = {}

# ✨ Language-specific system instructions
INSTRUCTIONS = {
    "en": """
You are Flamo — an AI chatbot that helps hotel staff and users with fire safety awareness, extinguisher usage, evacuation planning, and drills.
Your responses should be clear, practical, and step-by-step.
""",
    "hi": """
आप Flamo हैं, एक AI चैटबॉट जो होटल स्टाफ और उपयोगकर्ताओं को अग्नि सुरक्षा, अग्निशामक उपयोग, आग लगने की स्थिति में व्यवहार और ड्रिल में हिंदी में मार्गदर्शन करता है।
आपका उत्तर संक्षिप्त, व्यावहारिक और स्पष्ट होना चाहिए। जटिल शब्दों से बचें।
"""
}

@app.route('/')
def home():
    return "🔥 Flamo Fire Safety Chatbot API is running!"

@app.route('/chat', methods=['POST'])
def flamo_chat():
    data = request.json
    user_message = data.get("message", "")
    lang = data.get("lang", "en").lower()
    session_id = data.get("session_id", "default")

    if not user_message:
        return jsonify({"error": "No message provided."}), 400

    if lang not in INSTRUCTIONS:
        lang = "en"

    try:
        # 🧠 Create new session if not exists
        if session_id not in chat_sessions:
            model = genai.GenerativeModel(
                model_name="gemini-1.5-pro",
                system_instruction=INSTRUCTIONS[lang]
            )
            chat_sessions[session_id] = model.start_chat()

        chat = chat_sessions[session_id]

        # 🤖 Generate response
        response = chat.send_message(user_message)
        return jsonify({
            "response": response.text.strip()
        })

    except Exception as e:
        return jsonify({"error": str(e)}), 500

if __name__ == "__main__":
    app.run(debug=True, port=5000)
