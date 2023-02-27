document.addEventListener("DOMContentLoaded", () => {
    (
        document.querySelectorAll(
            ".modal-background, .modal-close, .modal-card-head .delete, .modal-card-foot .button"
        ) || []
    ).forEach(($close) => {
        const $target = $close.closest(".modal");

        $close.addEventListener("click", () => {
            closeModal($target);
        });
    });

    // Add a keyboard event to close all modals
    document.addEventListener("keydown", (event) => {
        const e = event || window.event;

        if (e.keyCode === 27) {
            // Escape key
            closeAllModals();
        }
    });

    function openModal($el) {
        $el.classList.add("is-active");
    }

    function closeModal($el) {
        $el.classList.remove("is-active");
    }

    function closeAllModals() {
        (document.querySelectorAll(".modal") || []).forEach(($modal) => {
            closeModal($modal);
        });
    }

    (document.querySelectorAll(".js-modal-trigger") || []).forEach(
        ($trigger) => {
            const modal = $trigger.dataset.target;
            const site = $trigger.dataset.site;
            const $modalTarget = document.getElementById(modal);

            $trigger.addEventListener("click", () => {
                const url = window.location.href;
                const index = url.lastIndexOf("/");
                const path = url.substring(0, index);
                const documentUrl = path + "/" + site;

                const $modalContentTarget = document.getElementById("cache-list-modal-box-content");

                fetch(documentUrl).then((response) => {
                    response.text().then((text) => {
                        $modalContentTarget.innerHTML = text;
                        openModal($modalTarget);
                    });
                });
            });
        }
    );

    function loadModal(site, modalId) {
        const url = window.location.href;
        const index = url.lastIndexOf("/");
        const path = url.substring(0, index);
        const documentUrl = path + "/" + site;

        const $modalTarget = document.getElementById(modalId);
        const $modalContentTarget = document.getElementById(
            modalId + "-content"
        );

        console.log("Loading modal content from " + documentUrl);

        fetch(documentUrl).then((response) => {
            response.text().then((text) => {
                $modalContentTarget.innerHTML = text;
                openModal($modalTarget);
            });
        });
    }
});
