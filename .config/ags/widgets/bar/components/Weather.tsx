import { bind } from "astal";
import { Gtk } from "astal/gtk4";
import { Revealer } from "astal/gtk4/widget";
import { Weather as WeatherService } from "services/weather";

export default function Weather() {
    const weatherData = bind(WeatherService)

    return (
        <Revealer
            transitionType={Gtk.RevealerTransitionType.CROSSFADE}
            transitionDuration={300}
            revealChild={bind(weatherData).as(Boolean)}
        >
            <box cssClasses={["weather", "bar-item"]} spacing={4} valign={Gtk.Align.CENTER}>
                <label label={bind(weatherData).as((w) => w === null ? "" : WEATHER_SYMBOL[w.current.condition.text])} />
                <label label={bind(weatherData).as((w) => w === null ? "" : `${w.current.temp_c}°`)} />
            </box>
        </Revealer>
    )
}

const WEATHER_SYMBOL: {
    [key: string]: string;
} = {
    default: "✨",
    Sunny: "🌞",
    Clear: "🌙",
    "Partly cloudy": "⛅",
    Cloudy: "☁️",
    Overcast: "🌥",
    Mist: "🌫",
    "Patchy rain possible": "🌦",
    "Patchy rain nearby": "🌦",
    "Patchy snow possible": "🌨",
    "Patchy sleet possible": "🌧",
    "Patchy freezing drizzle possible": "🌧❄️",
    "Thundery outbreaks possible": "🌩",
    "Blowing snow": "❄️💨",
    Blizzard: "🌨💨",
    Fog: "🌫",
    "Freezing fog": "🌫❄️",
    "Patchy light drizzle": "🌦",
    "Light drizzle": "🌦",
    "Freezing drizzle": "🌧❄️",
    "Heavy freezing drizzle": "🌧❄️",
    "Patchy light rain": "🌦",
    "Light rain": "🌧",
    "Moderate rain at times": "🌧",
    "Moderate rain": "🌧",
    "Heavy rain at times": "🌧🌩",
    "Heavy rain": "🌧🌩",
    "Light freezing rain": "🌧❄️",
    "Moderate or heavy freezing rain": "🌧❄️",
    "Light sleet": "🌨",
    "Moderate or heavy sleet": "🌨",
    "Patchy light snow": "❄️",
    "Light snow": "❄️",
    "Patchy moderate snow": "❄️",
    "Moderate snow": "❄️",
    "Patchy heavy snow": "❄️🌨",
    "Heavy snow": "❄️🌨",
    "Ice pellets": "🧊",
    "Light rain shower": "🌦",
    "Moderate or heavy rain shower": "🌧",
    "Torrential rain shower": "🌧🌩",
    "Light sleet showers": "🌨",
    "Moderate or heavy sleet showers": "🌨",
    "Light snow showers": "🌨",
    "Moderate or heavy snow showers": "❄️🌨",
    "Light showers of ice pellets": "🧊",
    "Moderate or heavy showers of ice pellets": "🧊",
    "Patchy light rain with thunder": "⛈",
    "Moderate or heavy rain with thunder": "⛈",
    "Patchy light snow with thunder": "🌩❄️",
    "Moderate or heavy snow with thunder": "🌩❄️",
};
