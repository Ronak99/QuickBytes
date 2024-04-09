
interface IApiSuccess {
  data: any;
  message?: string;
}
function ApiSuccess({ data, message }: IApiSuccess) {
  return { ok: true, message, data };
}

export default ApiSuccess;
