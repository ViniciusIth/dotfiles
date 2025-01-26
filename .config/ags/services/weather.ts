import { Variable } from "astal";

const weatherCommand = [
    "curl",
    "https://api.weatherapi.com/v1/forecast.json?key=caefc3e178484e2da38112101240404&q=Brasilia&days=1&aqi=no&alerts=no",
];

export const Weather = Variable<any | null>(null).poll(
    60_000,
    weatherCommand,
    (data) => JSON.parse(data),
)
