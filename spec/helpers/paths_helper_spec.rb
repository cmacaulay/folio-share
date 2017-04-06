require "rails_helper"

RSpec.describe PathsHelper do
  describe "#folder_or_upload_path" do
    it "returns the folder path when the child is a folder" do
      child = create(:folder)

      expect(folder_or_upload_path(child)).to eq(folder_path(child))
    end

    it "returns the upload path when the child is an upload" do
      child = create(:upload)

      expect(folder_or_upload_path(child)).to eq(upload_path(child))
    end
  end

  describe "#folder_or_folio_path" do
    it "returns the folder path if it is the root folder" do
      root = create(:folder)

      expect(folder_or_folio_path(root)).to eq(folio_path)
    end

    it "returns the folder path if it isn't the root folder" do
      root = create(:folder)
      folder = create(:folder, parent: root)

      expect(folder_or_folio_path(folder)).to eq(folder_path(folder))
    end
  end

  describe "#public_folder_or_upload_path" do
    it "returns the public folder path when the child is a folder" do
      child = create(:folder)

      expect(public_folder_or_upload_path(child)).to eq(public_folder_path(child))
    end

    it "returns the public upload path when the child is an upload" do
      child = create(:upload)

      expect(public_folder_or_upload_path(child)).to eq(public_upload_path(child))
    end
  end

  describe "#back_path" do
    it "returns the specified default path if there is an error" do
      default_path = folio_path

      expect(back_path(default_path)).to eq(folio_path)
    end

    xit "returns a path to previous page" do
      # I don't know how to make a model test for this since it depends on a page request.
    end
  end
end