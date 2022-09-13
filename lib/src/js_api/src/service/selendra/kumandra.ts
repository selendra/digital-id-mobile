import axios from "axios";
// import config from "./config";

// export default function Kumandra() {

//   return {
//     get(cid = "") {
//       return api
//         .get(`/files/${cid}`)
//         .then((response) => response.data)
//         .catch((error) => error);
//     },
    
//     addFile(file, file_name) {
//       const form = new FormData();
//       form.append("1", file, file_name);
//       return api
//         .post(`/api/add`, form)
//         .then((response) => response.data)
//         .catch((error) => error);
//     },
//   };
// }


/// URL for KUMANDRA NTFS API
async function addJson(jsonString = "{}", url: string, schemaId: string) {

    console.log("addJson");

    const api = axios.create({
        baseURL: url,
    });

    const form = new FormData();
    const json = new Blob([jsonString], { type: "application/json" });
    form.append(schemaId, json, "file.json");
    return api
      .post(`/api/add`, form)
      .then((response) => response.data.Hash)
      .catch((error) => error);
};

async function uploadImage(image: string, url: string, schemaId: string) {

    console.log("uploadImage");

    const api = axios.create({
        baseURL: url,
    });

    const form = new FormData();
    const file = new Blob([image], { type: "application/json" });
    form.append(schemaId, file, "photo");
    return api
      .post(`/api/add`, form)
      .then((response) => response.data.Hash)
      .catch((error) => error);
};

export default {
    addJson,
    uploadImage
};