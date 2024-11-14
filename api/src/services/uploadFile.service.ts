import path from 'path';

const uploadFileService = async (fileObject: any) => {
    let uploadPath = path.resolve(process.cwd(), '../../../src/assets/fileUpload');
    let extName = path.extname(fileObject.name);
    let baseName = path.basename(fileObject.name, extName);

    let finalName = `${baseName}-${Date.now()}${extName}`;
    let finalPath = `${uploadPath}/${finalName}`;
    try {
        await fileObject.mv(finalPath);
        return ({
            status: 'success',
            path: finalPath,
            error: null,
            message: 'Upload file successfully!'
        })
    } catch (error) {
        console.log(">>> Error upload file = ", error);
        return ({
            status: "false",
            path: null,
            error: JSON.stringify(error),
            message: "Upload file fail!"
        })
    } 
}

export default uploadFileService;