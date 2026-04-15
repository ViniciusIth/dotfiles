import { tool } from "@opencode-ai/plugin"
import { $ } from "bun"

type Ctx = { directory: string }
const schema = tool.schema


function clean(out: string | null | undefined): string {
    return (out ?? "").trim()
}

function shellEscape(arg: string) {
    return `'${arg.replace(/'/g, "'\\''")}'`
}

async function runBd(ctx: Ctx, args: string[], opts?: { empty?: string }) {
    const cmd = ["bd", ...args.map(shellEscape)].join(" ")

    const result = await $`${cmd}`
        .cwd(ctx.directory)
        .nothrow()
        .text()

    const text = clean(result)
    return text || (opts?.empty ?? "")
}

function push(cmd: string[], flag: string, value?: string | number) {
    if (value !== undefined) cmd.push(flag, String(value))
}

function flag(cmd: string[], name: string, enabled?: boolean) {
    if (enabled) cmd.push(name)
}

const taskId = schema.string().describe("Beads task ID (e.g. bd-a1b2)")


// bd prime
export const prime = tool({
    description: "Load session context (run at start).",
    args: {},
    async execute(_, ctx) {
        return runBd(ctx, ["prime"])
    },
})

// bd ready
export const ready = tool({
    description: "List tasks ready to work on.",
    args: {},
    async execute(_, ctx) {
        return runBd(ctx, ["ready", "--json"], { empty: "[]" })
    },
})

// bd blocked
export const blocked = tool({
    description: "List blocked tasks.",
    args: {},
    async execute(_, ctx) {
        return runBd(ctx, ["blocked", "--json"], { empty: "[]" })
    },
})


// bd create
export const create = tool({
    description: "Create a new task.",
    args: {
        title: schema.string().min(1),
        description: schema.string().optional(),
        priority: schema.number().min(0).max(4).optional(),
        type: schema.enum(["task", "epic", "bug", "feature"]).optional(),
        deps: schema.string().optional(),
    },
    async execute(args, ctx) {
        const cmd = ["create", args.title]

        push(cmd, "--description", args.description)
        push(cmd, "-p", args.priority)
        push(cmd, "-t", args.type)
        push(cmd, "--deps", args.deps)

        return runBd(ctx, cmd)
    },
})

// bd list
export const list = tool({
    description: "List tasks.",
    args: {
        status: schema.string().optional(),
        type: schema.string().optional(),
        json: schema.boolean().optional(),
    },
    async execute(args, ctx) {
        const cmd = ["list"]

        push(cmd, "--status", args.status)
        push(cmd, "--type", args.type)
        flag(cmd, "--json", args.json)

        return runBd(ctx, cmd, { empty: args.json ? "[]" : "" })
    },
})

// bd show
export const show = tool({
    description: "Show task details.",
    args: { id: taskId },
    async execute(args, ctx) {
        return runBd(ctx, ["show", args.id])
    },
})

// bd update (minimal safe version)
export const update = tool({
    description: "Update a task.",
    args: {
        id: taskId,
        title: schema.string().optional(),
        priority: schema.number().min(0).max(4).optional(),
        description: schema.string().optional(),
    },
    async execute(args, ctx) {
        const cmd = ["update", args.id]

        push(cmd, "--title", args.title)
        push(cmd, "-p", args.priority)
        push(cmd, "--description", args.description)

        return runBd(ctx, cmd)
    },
})

// bd update --claim
export const claim = tool({
    description: "Claim a task.",
    args: { id: taskId },
    async execute(args, ctx) {
        return runBd(ctx, ["update", args.id, "--claim"])
    },
})

// bd close
export const close = tool({
    description: "Close a task.",
    args: {
        id: taskId,
        reason: schema.string().min(1),
    },
    async execute(args, ctx) {
        return runBd(ctx, ["close", args.id, "--reason", args.reason])
    },
})

// bd reopen
export const reopen = tool({
    description: "Reopen a task.",
    args: { id: taskId },
    async execute(args, ctx) {
        return runBd(ctx, ["reopen", args.id])
    },
})


// bd dep add
export const depAdd = tool({
    description: "Add dependency (A depends on B).",
    args: {
        from: taskId,
        to: taskId,
    },
    async execute(args, ctx) {
        return runBd(ctx, ["dep", "add", args.from, args.to])
    },
})

// bd dep remove
export const depRemove = tool({
    description: "Remove dependency.",
    args: {
        from: taskId,
        to: taskId,
    },
    async execute(args, ctx) {
        return runBd(ctx, ["dep", "remove", args.from, args.to])
    },
})

// bd dep tree
export const depTree = tool({
    description: "Show dependency tree.",
    args: { id: taskId },
    async execute(args, ctx) {
        return runBd(ctx, ["dep", "tree", args.id])
    },
})


// bd comment add
export const commentAdd = tool({
    description: "Add a comment to a task.",
    args: {
        id: taskId,
        body: schema.string().min(1),
    },
    async execute(args, ctx) {
        return runBd(ctx, ["comment", "add", args.id, args.body])
    },
})

// bd comment list
export const commentList = tool({
    description: "List comments for a task.",
    args: {
        id: taskId,
    },
    async execute(args, ctx) {
        return runBd(ctx, ["comment", "list", args.id])
    },
})


// bd search
export const search = tool({
    description: "Search tasks.",
    args: {
        query: schema.string().min(1),
        json: schema.boolean().optional(),
    },
    async execute(args, ctx) {
        const cmd = ["search", args.query]
        flag(cmd, "--json", args.json)
        return runBd(ctx, cmd, { empty: args.json ? "[]" : "" })
    },
})
