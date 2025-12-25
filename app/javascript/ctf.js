window.MathJax = {
  loader: {
    paths: {
      mathjax: 'https://cdn.jsdelivr.net/npm/mathjax@3/es5'
    },
    load: ['input/tex-full', 'output/chtml', '[tex]/color']
  },
  options: {
    skipHtmlTags: ["script","noscript","style","textarea"]
  },
  tex: {
    packages: {
      '[+]': ['color']
    },
    inlineMath: [['$','$'], ['\\(','\\)']],
    displayMath: [['$$','$$'], ['\\[','\\]']]
  },
  startup: {
    pageReady() {
      function updateScrollClasses() {
        document.querySelectorAll('.MathJax').forEach(el => {
          if (el.scrollWidth > el.clientWidth) {
            el.classList.add('has-scroll');
          } else {
            el.classList.remove('has-scroll');
          }
        });
      }
      return MathJax.startup.defaultPageReady().then(() => {
        updateScrollClasses();
        window.addEventListener('resize', updateScrollClasses);
      });
    }
  }
};

document.querySelectorAll('.ctf-card').forEach(card => {
  card.addEventListener('transitionend', event => {
    if (!card.classList.contains('expanded')) {
      card.style.zIndex = '';
    }
  });
  card.addEventListener('click', function () {
    document.querySelectorAll('.ctf-card').forEach(otherCard => {
      if (otherCard !== card) {
        otherCard.classList.remove('expanded');
        otherCard.style.transform = '';
        otherCard.style.transition = 'transform 0.3s ease-in-out';
      }
    });

    if (!card.classList.contains('expanded')) {
      card.classList.add('expanded');
      card.style.zIndex = '10';

      const rect = card.getBoundingClientRect();
      const centerX = rect.left + rect.width / 2;
      const centerY = rect.top + rect.height / 2;
      const viewportWidth = window.innerWidth;
      const viewportHeight = window.innerHeight;

      const translateY = (viewportHeight / 2) - centerY;
      const translateX = (viewportWidth / 2) - centerX;

      const minDimension = Math.min(rect.width, rect.height);
      const minViewport = Math.min(viewportWidth, viewportHeight);
      const targetScale = minViewport / minDimension * 0.9;

      card.style.transform = `translate(${translateX}px, ${translateY}px) scale(${targetScale})`;
      card.style.transition = 'transform 0.3s ease-in-out';
    } else {
      card.classList.remove('expanded');
      card.style.transform = '';
      requestAnimationFrame(() => {
        card.style.transition = 'transform 0.3s ease-in-out';
        card.style.transform = '';
      });
      setTimeout(() => {
        card.style.zIndex = '';
      }, 500);
    }
  });

  card.querySelectorAll('.ctf-button').forEach(button => {
    button.addEventListener('click', function (event) {
      event.stopPropagation();
    });
  });
});

document.addEventListener('click', function(event) {
  if (!event.target.closest('.ctf-card')) {
    const expandedCard = document.querySelector('.ctf-card.expanded');
    if (expandedCard) {
      expandedCard.classList.remove('expanded');
      expandedCard.style.transform = '';
      expandedCard.style.transition = 'transform 0.3s ease-in-out';
    }
  }
});


document.addEventListener("DOMContentLoaded", function () {
    const tocLinks = document.querySelectorAll(".toc-anchor");
    const headings = document.querySelectorAll(".markdown-content h1, .markdown-content h2, .markdown-content h3");

    if (tocLinks.length > 0) {
      tocLinks[0].classList.add("active-anchor");
    }

    function highlightCurrentSection() {
      let scrollPosition = window.scrollY + 10;

      let currentSection = null;
      headings.forEach((heading) => {
        const anchor = heading.querySelector("a[id]");
        if (anchor && anchor.offsetTop <= scrollPosition) {
          currentSection = anchor;
        }
      });

      if (currentSection) {
        tocLinks.forEach((link) => {
          link.classList.remove("active-anchor");
          if (link.getAttribute("href") === `#${currentSection.id}`) {
            link.classList.add("active-anchor");
          }
        });
      }
    }

    window.addEventListener("scroll", highlightCurrentSection);
    highlightCurrentSection();

    /* TOC toggle using Tailwind utility classes (avoid .collapse collision) */
    document.querySelectorAll('[data-toc-toggle]').forEach(btn => {
      btn.addEventListener('click', (e) => {
        const targetId = btn.getAttribute('data-toc-toggle') || btn.getAttribute('aria-controls');
        const toc = document.getElementById(targetId);
        if (!toc) return;

        const nowHidden = toc.classList.toggle('hidden');
        const expanded = (!nowHidden).toString();
        btn.setAttribute('aria-expanded', expanded);
      });
    });
});

document.addEventListener('click', event => {
  const btn = event.target.closest('.copy-btn');
  if (!btn) return;

  const code = btn.getAttribute('data-code');
  navigator.clipboard.writeText(code)
    .then(() => {
      btn.textContent = '✅';
      setTimeout(() => btn.textContent = '📋', 2000);
    })
    .catch(() => {
      btn.textContent = 'Error';
    });
});


const btn = document.getElementById("toc-toggle");
const icon = document.getElementById("toc-toggle-icon");
const toc  = document.getElementById("toc");

btn.addEventListener("click", () => {
  const expanded = btn.getAttribute("aria-expanded") === "true";
  if (expanded) {
    icon.classList.add("rotate-180");
  } else {
    icon.classList.remove("rotate-180");
  }
});