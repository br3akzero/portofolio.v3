import './style.css'
import { setupCounter } from './counter.ts'

document.querySelector<HTMLDivElement>('#app')!.innerHTML += `<p>Generated</p>`

setupCounter(document.querySelector<HTMLButtonElement>('#counter')!)
