import { Article, Relevancy } from "../models/article";
import { Category, NewsNotification } from "../models/app_notification";
import { notificationService } from "../services";
import catchAsync from "../../utils/catchAsync";
import httpStatus from "http-status";
import ApiSuccess from "../../utils/ApiSuccess";

const notifyTopic = catchAsync(async (req, res) => {
  const notification: NewsNotification = {
    topic: "entertainment_all",
    payload: {
      article: {
        id: "random-article-1",
        title: "News Title",
        content: "Content",
        image:
          "https://png.pngtree.com/thumb_back/fh260/background/20230519/pngtree-landscape-jpg-wallpapers-free-download-image_2573540.jpg",
        published_on: new Date(),
        category_list: ["entertainment", "politics"],
        relevancy: Relevancy.all,
        source_url: "https://www.google.com",
      },
      category: Category.deliverNews,
    },
  };

  const response = await notificationService.notifyTopic(notification);

  res.status(httpStatus.OK).send(
    ApiSuccess({
      message: `Notification Sent!`,
      data: response,
    })
  );
});

export default { notifyTopic };
