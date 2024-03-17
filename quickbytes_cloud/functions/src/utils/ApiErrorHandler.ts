import ApiError from "./ApiError"

// export const ApiErrorHandler = (error: ApiError, response: any) => {
//     response.status(error.statusCode).send({
//         'error': {
//             'message': error.message,
//             'name': error.name,
//         },
//     })
// }

class ApiErrorHandler {
    error: ApiError;
    response: any;

    constructor(
        error: ApiError,
        response: any,
    ) {
        this.error = error
        this.response = response
        response.status(error.statusCode).send({
            'error': {
                'message': error.message,
                'name': error.name,
            },
        })
    }
}

export default ApiErrorHandler