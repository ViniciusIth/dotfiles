import { Variable } from "astal";
import { App } from "astal/gtk4";

export const popupWindows = Variable<Array<string>>([]);

export function getAllPopupWindows() {
    return App.get_windows().filter(
        (window) => window.visible,
    );
};

export function getpopupWindow(windowName: string) {
    return App.get_windows().filter(
        (window) => popupWindows.get().includes(windowName) && window.visible,
    );
};

export function addpopupWindow(windowName: string) {
    popupWindows.set([...popupWindows.get(), windowName]);
};

export function removepopupWindow(windowName: string) {
    popupWindows.set(popupWindows.get().filter((name) => name !== windowName));
};
