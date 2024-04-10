export enum Relevancy {
  all = "all",
  major = "major",
}

export interface NewsCategory {
  name: string;
  relevancy: Relevancy;
  label: string;
}
