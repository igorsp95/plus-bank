// const skeletonWorking = () => {
//   const loadings = document.querySelectorAll(".loading");
//   const titleH1 = document.querySelectorAll(".loading h1");
//   const titleH2 = document.querySelectorAll(".loading h2");
//   const btn6 = document.querySelectorAll(".loading .button-6");
//   const tableTh = document.querySelectorAll(".loading th");
//   const tableTd = document.querySelectorAll(".loading td");
  
//   const renderCard = () => {
//     loadings.forEach((loading) => {
//       loading.classList.remove('skeleton');
//     });

//     titleH1.forEach((h) => {
//       h.style.visibility = "visible" ;
//     });

//     titleH2.forEach((h) => {
//       h.style.visibility = "visible" ;
//     });

//     btn6.forEach((btn) => {
//       btn.style.visibility = "visible" ;
//     });

//     tableTh.forEach((th) => {
//       th.style.visibility = "visible" ;
//     });

//     tableTd.forEach((td) => {
//       td.style.visibility = "visible" ;
//     });
//   };
  
//   setTimeout(() => {
//     renderCard();
//   }, 1000);
// }

// export { skeletonWorking };