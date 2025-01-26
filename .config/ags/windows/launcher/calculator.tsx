import { execAsync } from "astal"

function preprocessExpression(exp: string): string {
    return exp.replace(/(\d)(\()/g, "$1*(").replace(/(\))(\d)/g, ")*$2");
};

async function evaluate(expression: string): Promise<string> {
    try {
        const command = `kalker "${expression}"`
        const result = await execAsync(command)
        return result.trim()
    } catch (e) {
        return (e as Error).message
    }
}

async function resultLabel(expression: string) {
    const result = await evaluate(preprocessExpression(expression))

    return (
        <label
            label={result}
            cssClasses={["result"]}
        />
    )
}

export default function CalculatorEntry(expression: string) {
    return (
        <box
            name="calculator"
            cssClasses={["launcher-entry", "calculator"]}
        >
            {resultLabel(expression)}
        </box>
    )
}
