const loaderWorking = () => {
  let skeletonTemplate = document.querySelector('.skeleton-template');
  
  window.addEventListener('load', function () {
    // spinnerWrapper.style.display = 'none';
    skeletonTemplate.parentElement.removeChild(skeletonTemplate);
  });
}

export { loaderWorking };
