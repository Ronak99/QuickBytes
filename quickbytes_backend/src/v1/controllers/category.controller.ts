import httpStatus from "http-status";
import ApiSuccess from "../../utils/ApiSuccess";
import catchAsync from "../../utils/catchAsync";
import { categoryService } from "../services";

const createCategory = catchAsync(async (req, res) => {
  const response = await categoryService.createCategory(req.body);

  res.status(httpStatus.CREATED).send(
    ApiSuccess({
      message: `Created Category!`,
      data: response,
    })
  );
});

const queryCategories = catchAsync(async (req, res) => {
  const response = await categoryService.queryCategories();

  res.status(httpStatus.OK).send(
    ApiSuccess({
      message: `Query Categories.`,
      data: response,
    })
  );
});

const testing = catchAsync(async (req, res) => {
  const response = await categoryService.testing();

  res.status(httpStatus.OK).send(
    ApiSuccess({
      message: `Category Testing.`,
      data: response,
    })
  );
});

export default {
  createCategory,
  queryCategories,
  testing,
};
