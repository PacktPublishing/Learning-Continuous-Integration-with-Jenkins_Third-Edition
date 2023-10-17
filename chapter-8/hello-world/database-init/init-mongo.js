db = db.getSiblingDB('helloworldapp'); // select helloworldapp database

db.greetings.insertMany([
    { language: "English", message: "Hello World" },
    { language: "French", message: "Bonjour le Monde" },
    { language: "Spanish", message: "Hola Mundo" },
    { language: "German", message: "Hallo Welt" },
    { language: "Italian", message: "Ciao Mondo" },
    { language: "Portuguese", message: "Olá Mundo" },
    { language: "Dutch", message: "Hallo Wereld" },
    { language: "Russian", message: "Привет мир" },
    { language: "Japanese", message: "こんにちは世界" },
    { language: "Chinese", message: "你好，世界" },
    { language: "Korean", message: "안녕하세요 세계" },
    { language: "Arabic", message: "مرحبا بالعالم" },
    { language: "Turkish", message: "Merhaba Dünya" },
    { language: "Swedish", message: "Hej Världen" },
    { language: "Norwegian", message: "Hei Verden" },
    { language: "Danish", message: "Hej Verden" },
    { language: "Finnish", message: "Hei Maailma" },
    { language: "Polish", message: "Witaj świecie" },
    { language: "Hungarian", message: "Helló Világ" },
    { language: "Greek", message: "Γειά σας Κόσμος" }
]);
