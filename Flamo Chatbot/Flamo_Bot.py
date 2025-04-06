import google.generativeai as genai

# 🔐 Step 1: Gemini API key input
api_key = input("Enter your Gemini API key: ")
genai.configure(api_key=api_key)

# 🧾 Step 2: Welcome message
welcome_message = """
👋 Hello! I’m *Flamo*, your AI-powered fire safety assistant.

🧯 Whether you're preparing for an emergency or facing one, I’ll guide you with step-by-step advice on fire extinguishers, evacuation, and drills.

Please choose your language to continue:
- Type *English* or *E* for English
- Type *Hindi* or *H* for Hindi

👋 नमस्ते! मैं *Flamo* हूँ — आपका AI अग्नि सुरक्षा सहायक।

🧯 अगर आप आपातकाल के लिए तैयारी कर रहे हैं या उसका सामना कर रहे हैं, तो मैं आपको सही कदम उठाने में मदद करूंगा।

कृपया आगे बढ़ने के लिए अपनी भाषा चुनें:
- अंग्रेजी के लिए *English* या *E* टाइप करें
- हिंदी के लिए *Hindi* या *H* टाइप करें
"""
print(welcome_message)

# 🌐 Step 3: Language selection
lang = input("🌐 Choose your language (English/Hindi): ").strip().lower()

# 🧠 Step 4: Language-based system instruction
if lang in ['hindi', 'h']:
    system_instruction = """
आप Flamo हैं — एक AI चैटबॉट जो केवल होटल स्टाफ को अग्नि सुरक्षा, निकासी योजनाएं, अग्निशामक उपयोग और फायर ड्रिल जैसी जानकारी देने के लिए प्रशिक्षित है।

आप केवल होटल में अग्नि सुरक्षा से जुड़े प्रश्नों के उत्तर दें।

अगर कोई उपयोगकर्ता गैर-संबंधित विषय पर सवाल पूछे, तो विनम्रता से कहें:
"मैं केवल होटल स्टाफ के लिए अग्नि सुरक्षा संबंधित विषयों में मदद करने के लिए प्रशिक्षित हूँ।"

✅ आप इन जैसे प्रश्नों के उत्तर दे सकते हैं:
- आग बुझाने वाले यंत्र का उपयोग कैसे करें?
- होटल में आग लगने पर क्या करें?
- फायर ड्रिल की प्रक्रिया क्या है?
- निकासी मार्ग की योजना कैसे बनाएं?

❌ उत्तर न दें:
- व्यक्तिगत, सामान्य या अन्य विषयों पर
- मजाक, सामान्य ज्ञान, या कोई भी गैर-सुरक्षा विषय

उत्तर संक्षिप्त, स्पष्ट और कदम दर कदम दें।
"""
    print("\n✅ भाषा चुनी गई: हिंदी\n")
else:
    system_instruction = """
You are Flamo — an AI chatbot trained specifically to help hotel staff with fire safety awareness, evacuation planning, extinguisher usage, and fire drills.

Your goal is to answer questions ONLY related to fire safety in the hotel environment.

If the user asks anything that is not related to fire safety, politely say:
"I'm here to assist only with fire safety-related topics for hotel staff."

✅ You can answer things like:
- How to use a fire extinguisher
- What to do during a hotel fire
- Fire drill procedures
- Evacuation route planning
- Fire extinguisher types and usage

❌ You should not answer:
- Personal, general, or unrelated topics
- Jokes, trivia, or anything not related to hotel fire safety

Respond in short, clear, step-by-step instructions when possible.
"""
    print("\n✅ Language selected: English\n")

# 🔥 Step 5: Initialize Gemini model with system prompt
model = genai.GenerativeModel(
    model_name="gemini-1.5-pro",
    system_instruction=system_instruction
)

chat = model.start_chat()

# 💬 Step 6: Start chat loop
while True:
    user_input = input("👤 You: ")
    if user_input.lower() in ["exit", "quit","bye"]:
        print("👋 Flamo: Stay safe! Chat ended.")
        break

    try:
        response = chat.send_message(user_input)
        print("🔥 Flamo:", response.text)
    except Exception as e:
        print("⚠ Error:", str(e))