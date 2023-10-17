fetch('/api/helloworlds')
    .then(response => response.json())
    .then(data => {
        const greetingsDiv = document.getElementById('greetings');
        data.forEach(greeting => {
            greetingsDiv.innerHTML += `<p>${greeting.language}: ${greeting.message}</p>`;
        });
    })
    .catch(error => console.error('Error:', error));