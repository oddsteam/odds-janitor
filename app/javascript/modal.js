// // modal.js

// // Select elements
// const modal = document.getElementById('myModal');

// // Function to open the modal
// export function openModal({ startTime, endTime, cells }) {
//     // Populate the modal with the start and end times
//     const modal = document.getElementById('myModal');
//     const startTimeInput = document.getElementById('startTime');
//     const endTimeInput = document.getElementById('endTime');
  
//     startTimeInput.value = startTime;
//     endTimeInput.value = endTime;
  
//     // Show the modal
//     modal.classList.remove('hidden');
//   }
  

// // Function to close the modal
// export function closeModal() {
//     if (modal) {
//         modal.classList.add('hidden');
//     }
// }

// // Initialize event listeners
// document.addEventListener('DOMContentLoaded', () => {
//     const openModalBtn = document.querySelector('[data-modal-open]');
//     const closeModalBtns = [
//         document.getElementById('closeModal'),
//         document.getElementById('closeModalBtn')
//     ];

//     // Add event listener to open modal button
//     if (openModalBtn) {
//         openModalBtn.addEventListener('click', openModal);
//     }

//     // Add event listeners to close modal buttons
//     closeModalBtns.forEach(btn => {
//         if (btn) {
//             btn.addEventListener('click', closeModal);
//         }
//     });

//     // Optional: Close modal when clicking outside of it
//     window.addEventListener('click', (event) => {
//         if (modal && event.target === modal) {
//             closeModal();
//         }
//     });
// });
