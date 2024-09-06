document.addEventListener('DOMContentLoaded', () => {
    const openModalBtn = document.querySelector('[data-modal-open]');
    const closeModalBtn = document.getElementById('closeModal');
    const closeModalBtn2 = document.getElementById('closeModalBtn');
    const modal = document.getElementById('myModal');
  
    if (openModalBtn) {
        openModalBtn.addEventListener('click', () => {
            modal.classList.remove('hidden');
        });
    }
  
    if (closeModalBtn) {
        closeModalBtn.addEventListener('click', () => {
            modal.classList.add('hidden');
        });
    }

    if (closeModalBtn2) {
        closeModalBtn2.addEventListener('click', () => {
            modal.classList.add('hidden');
        });
    }
  
    // Optional: Close modal when clicking outside of it
    window.addEventListener('click', (event) => {
        if (event.target === modal) {
            modal.classList.add('hidden');
        }
    });
});
