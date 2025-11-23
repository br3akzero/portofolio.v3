import './style/style.css'

const emailBtn = document.querySelector<HTMLButtonElement>('.email');

if (emailBtn) {
  emailBtn.addEventListener('click', () => {
    const email = emailBtn.dataset.email;
    if (!email) return;

    // Fallback for non-HTTPS or older browsers
    const textArea = document.createElement('textarea');
    textArea.value = email;
    textArea.style.position = 'fixed';
    textArea.style.opacity = '0';
    document.body.appendChild(textArea);
    textArea.select();
    document.execCommand('copy');
    document.body.removeChild(textArea);

    emailBtn.textContent = 'Copied!';
    setTimeout(() => {
      emailBtn.textContent = email;
    }, 1000);
  });
}