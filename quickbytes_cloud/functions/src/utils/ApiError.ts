class ApiError extends Error {
    statusCode: number;
    isOperational: boolean;
    ok: boolean;
    info: null | any;

    constructor(
        statusCode: number,
        message: string | undefined,
        info: any = null,
        isOperational = true,
        stack = ""
    ) {
        super(message);
        this.statusCode = statusCode;
        this.isOperational = isOperational;
        if (stack) {
            this.stack = stack;
            this.ok = false;
            this.info = info;
        } else {
            Error.captureStackTrace(this, this.constructor);
            this.ok = false;
            this.info = info;
        }
    }
}

export default ApiError;