import AstalNetwork from "gi://AstalNetwork";
import { Gtk } from "astal/gtk3";
import { bind, execAsync } from "astal";
import icons from "lib/icons";
import { notify } from "lib/utils";
import Page from "widget/ControlCenter/Page";
import NM from "gi://NM?version=1.0";

const hasPassword = (ap: AstalNetwork.AccessPoint) => {
    // @ts-ignore
    const noPw = NM["80211ApSecurityFlags"].NONE;
    // @ts-ignore
    const apPrivacy = NM["80211ApFlags"].NONE;

    return !(ap.mode == noPw)
}

const checkStoredPassword = async (ssid: string): Promise<boolean> => {
    try {
        const result = await execAsync(`nmcli -s -g 802-11-wireless-security.psk connection show "${ssid}"`);
        return result.trim() !== "";
    } catch (error) {
        console.log(error)
        return false;
    }
};

const actions = {
    connect: async (ap: AstalNetwork.AccessPoint) => {
        console.log(hasPassword(ap))
        if (ap.rsnFlags) {
            const hasStoredPassword = await checkStoredPassword(ap.ssid);
            if (hasStoredPassword) {
                try {
                    await execAsync(`nmcli con up "${ap.ssid}"`);
                    await notify("WiFi", `Connected to ${ap.ssid}`);
                } catch (error) {
                    await notify("wifi error", `failed to connect ${ap.ssid}: ${error}`, "critical");
                    console.error(`failed to connect ${ap.ssid}: ${error}`);
                }
            } else {
                // Show password prompt
            }
        } else {
            await execAsync(`nmcli con up "${ap.ssid}"`);
        }
    },

    disconnect: async (ap: AstalNetwork.AccessPoint) => {
        try {
            await execAsync(`nmcli con down "${ap.ssid}"`);
            await notify("WiFi", `Disconnected from ${ap.ssid}`);
        } catch (error) {
            await notify("wifi error", `failed to disconnect ${ap.ssid}: ${error}`, "critical");
            console.error(`failed to disconnect ${ap.ssid}: ${error}`);
        }
    },

    forget: async (ap: AstalNetwork.AccessPoint) => {
        try {
            await execAsync(`nmcli connection delete "${ap.ssid}"`);
            await notify("WiFi", `Forgot ${ap.ssid}`);
        } catch (error) {
            await notify("wifi error", `failed to forget ${ap.ssid}: ${error}`, "critical");
            console.error(`failed to forget ${ap.ssid}: ${error}`);
        }
    }
}

const apBox = (ap: AstalNetwork.AccessPoint, network: AstalNetwork.Network) => {
    return (
        <button
            className="control-center__page_item"
            onClicked={() => {
                if (network.wifi.activeAccessPoint == ap) {
                    actions.disconnect(ap);
                    return
                }

                actions.connect(ap);
            }}
        >
            <box>
                <icon icon={ap.iconName} iconSize={20} />
                <label label={ap.ssid || ""} />
                <icon
                    visible={bind(
                        network.wifi,
                        "activeAccessPoint",
                    ).as((aap) => aap === ap)}
                    icon={icons.ui.tick}
                    hexpand
                    halign={Gtk.Align.END}
                />
                <icon
                    visible={hasPassword(ap)}
                    icon={icons.ui.lock}
                    halign={Gtk.Align.END}
                />
            </box>
        </button>
    )
}
export default () => {
    const network = AstalNetwork.get_default();

    if (network.wifi == null) {
        return null;
    }

    return (
        <Page
            label={"Network"}
            refresh={() => network.wifi.scan()}
            scanning={bind(network.wifi, "scanning")}
        >
            <box
                vertical
                spacing={8}
                className={"control-center__page_scrollable-content"}
            >
                <eventbox
                    onClickRelease={(_, event) => {
                        if (event.button !== 1) return;
                        if (network.wifi.enabled) {
                            network.wifi.enabled = false;
                        } else {
                            network.wifi.enabled = true;
                            network.wifi.scan();
                        }
                    }}
                >
                    <box
                        className="control-center__page_item-header"
                        setup={(self) => {
                            self.toggleClassName("active", network.wifi.enabled);
                            self.hook(network.wifi, "notify::enabled", () => {
                                self.toggleClassName("active", network.wifi.enabled);
                            });
                        }}
                    >
                        <icon icon={bind(network.wifi, "iconName")} />
                        <label
                            label={"Wi-Fi"}
                            hexpand
                            halign={Gtk.Align.START}
                        />
                        <switch
                            hexpand={false}
                            halign={Gtk.Align.END}
                            valign={Gtk.Align.CENTER}
                            active={bind(network.wifi, "enabled")}
                            onActivate={({ active }) =>
                                (network.wifi.enabled = active)
                            }
                        />
                    </box>
                </eventbox>
                <box vertical spacing={4}>
                    {bind(network.wifi, "accessPoints").as((points) =>
                        points.sort((a, b) => b.strength - a.strength).map((ap) => {
                            if (ap.ssid == "") return null;

                            return apBox(ap, network);
                        }),
                    )}
                </box>
            </box>
        </Page>
    );
};
