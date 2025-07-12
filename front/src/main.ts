import './style.css'
//import typescriptLogo from './typescript.svg'
//import viteLogo from '/vite.svg'
//import { setupCounter } from './counter.ts'

interface HiModel {
  text: string;
}

const api = import.meta.env.VITE_API_URL || 'http://localhost:5000';
let names = ["John", "Jane", "Doe", "Alice", "Bob", "Charlie", "Eve", "Mallory", "Trent", "Victor"];

// const response = await fetch(api + "/hi/John", {
//   method: "GET",
//   headers: {
//     "Content-Type": "application/json"
//   }
// });
// const data: HiModel = await response.json();
// const text = data.text || "No text received from API";


document.querySelector<HTMLDivElement>('#app')!.innerHTML =
  `
<h1>Library Manga</h1>
<button id="random" type="button" onclick="greetRandom()">RaNdOm</button>
<h2 id="greeting"></h2>`
greetRandom();

 function greetRandom() {
  const randomName = names[Math.floor(Math.random() * names.length)];
  fetch(api + '/hi/' + randomName)
    .then(response => response.json())
    .then(data => {
        const greetingElem = document.querySelector('#greeting');
        if (greetingElem) {
          greetingElem.innerHTML = data.text || "No text received from API";
        }
    });
}
(window as any).greetRandom = greetRandom;